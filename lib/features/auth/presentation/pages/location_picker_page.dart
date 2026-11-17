import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LocationResult {
  final double latitude;
  final double longitude;
  final String? address;

  const LocationResult({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}

class LocationPickerPage extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;
  final String? initialAddress;

  const LocationPickerPage({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
    this.initialAddress,
  });

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final MapController _mapController = MapController();
  late LatLng _currentCenter;
  String? _resolvedAddress;
  bool _isLoadingAddress = false;
  bool _isGettingGps = false;
  Timer? _debounceTimer;

  // Default to Cairo center if not provided
  static const LatLng _cairoCenter = LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    final hasInitial =
        widget.initialLatitude != null && widget.initialLongitude != null;
    _currentCenter = hasInitial
        ? LatLng(widget.initialLatitude!, widget.initialLongitude!)
        : _cairoCenter;
    _resolvedAddress = widget.initialAddress;

    if (!hasInitial) {
      _fetchCurrentLocation(animate: false);
    } else if (_resolvedAddress == null) {
      _reverseGeocode(_currentCenter);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _fetchCurrentLocation({bool animate = true}) async {
    setState(() => _isGettingGps = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        final pos = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.medium,
            timeLimit: Duration(seconds: 5),
          ),
        );
        if (mounted) {
          final target = LatLng(pos.latitude, pos.longitude);
          setState(() {
            _currentCenter = target;
          });
          if (animate) {
            _mapController.move(target, 16.0);
          }
          _reverseGeocode(target);
        }
      }
    } catch (_) {
      // Graceful fallback to default center
    } finally {
      if (mounted) setState(() => _isGettingGps = false);
    }
  }

  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    _currentCenter = camera.center;
    if (hasGesture) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 700), () {
        if (mounted) {
          _reverseGeocode(_currentCenter);
        }
      });
    }
  }

  Future<void> _reverseGeocode(LatLng target) async {
    setState(() => _isLoadingAddress = true);
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 3),
          receiveTimeout: const Duration(seconds: 3),
          headers: {'User-Agent': 'rujeta_doctor_app/1.0'},
        ),
      );
      final isAr = Localizations.localeOf(context).languageCode == 'ar';
      final response = await dio.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'format': 'json',
          'lat': target.latitude,
          'lon': target.longitude,
          'accept-language': isAr ? 'ar' : 'en',
        },
      );
      if (response.data is Map && mounted) {
        final displayName = response.data['display_name'] as String?;
        if (displayName != null && displayName.isNotEmpty) {
          setState(() {
            _resolvedAddress = displayName;
          });
        }
      }
    } catch (_) {
      // Leave resolvedAddress or fallback to coordinate text
    } finally {
      if (mounted) setState(() => _isLoadingAddress = false);
    }
  }

  void _confirmSelection() {
    final finalAddress =
        (_resolvedAddress != null && _resolvedAddress!.trim().isNotEmpty)
            ? _resolvedAddress!.trim()
            : '${_currentCenter.latitude.toStringAsFixed(5)}, ${_currentCenter.longitude.toStringAsFixed(5)}';

    final result = LocationResult(
      latitude: _currentCenter.latitude,
      longitude: _currentCenter.longitude,
      address: finalAddress,
    );

    // If AuthBloc is available in context or injector, update it directly
    try {
      context.read<AuthBloc>().add(
            LocationSelectedEvent(
              latitude: _currentCenter.latitude,
              longitude: _currentCenter.longitude,
              address: finalAddress,
            ),
          );
    } catch (_) {
      try {
        injector<AuthBloc>().add(
              LocationSelectedEvent(
                latitude: _currentCenter.latitude,
                longitude: _currentCenter.longitude,
                address: finalAddress,
              ),
            );
      } catch (_) {}
    }

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.strings.chooseOnMap,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          // OpenStreetMap
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: 15.0,
              onPositionChanged: _onPositionChanged,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.fassladev.rujetaDoctor',
              ),
            ],
          ),

          // Center Pin (Fixed over the map crosshair)
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 38.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF005BEA),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF005BEA).withValues(alpha: 0.35),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // GPS My Location Floating Button
          Positioned(
            top: 16.h,
            left: isAr ? 16.w : null,
            right: isAr ? null : 16.w,
            child: Material(
              color: Colors.white,
              elevation: 4,
              borderRadius: BorderRadius.circular(30.r),
              child: InkWell(
                onTap: _isGettingGps ? null : () => _fetchCurrentLocation(),
                borderRadius: BorderRadius.circular(30.r),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: _isGettingGps
                      ? SizedBox(
                          width: 22.sp,
                          height: 22.sp,
                          child: const CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(
                          Icons.my_location,
                          color: const Color(0xFF005BEA),
                          size: 22.sp,
                        ),
                ),
              ),
            ),
          ),

          // Bottom Sheet with details & Confirm Button
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 24.h,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F1FF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Color(0xFF005BEA),
                          size: 22,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.strings.locationOnMap,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F1E36),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            if (_isLoadingAddress)
                              Row(
                                children: [
                                  SizedBox(
                                    width: 12.sp,
                                    height: 12.sp,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    isAr
                                        ? 'جاري تحديد العنوان...'
                                        : 'Loading address...',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                _resolvedAddress?.isNotEmpty == true
                                    ? _resolvedAddress!
                                    : '${_currentCenter.latitude.toStringAsFixed(5)}, ${_currentCenter.longitude.toStringAsFixed(5)}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12.sp,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF005BEA), Color(0xFF00C6FB)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: CustomElevatedButton(
                      text: isAr ? 'تأكيد الموقع' : 'Confirm Location',
                      icon: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      onPressed: _confirmSelection,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
