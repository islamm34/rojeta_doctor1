import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import '../../pages/location_picker_page.dart';

class MapLocationPickerButton extends StatelessWidget {
  final ValueChanged<LocationResult>? onLocationChanged;

  const MapLocationPickerButton({
    super.key,
    this.onLocationChanged,
  });

  Future<void> _openMapPicker(BuildContext context, AuthState state) async {
    final authBloc = context.read<AuthBloc>();
    final result = await Navigator.of(context).push<LocationResult>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: authBloc,
          child: LocationPickerPage(
            initialLatitude: state.latitude,
            initialLongitude: state.longitude,
            initialAddress: state.mapAddress,
          ),
        ),
      ),
    );

    if (result != null) {
      authBloc.add(
        LocationSelectedEvent(
          latitude: result.latitude,
          longitude: result.longitude,
          address: result.address,
        ),
      );
      onLocationChanged?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (p, c) =>
          p.latitude != c.latitude ||
          p.longitude != c.longitude ||
          p.mapAddress != c.mapAddress,
      builder: (context, state) {
        final hasLocation = state.latitude != null && state.longitude != null;

        if (!hasLocation) {
          // "+ Location" Button matching user's sketch
          return InkWell(
            onTap: () => _openMapPicker(context, state),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F7FF),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFF005BEA).withValues(alpha: 0.35),
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_location_alt_outlined,
                    color: Color(0xFF005BEA),
                    size: 20,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '+ Location',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF005BEA),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '(${context.strings.chooseOnMap})',
                    style: TextStyle(
                      color: const Color(0xFF005BEA).withValues(alpha: 0.75),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Selected Location Card with Edit & Clear
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFF27AE60).withValues(alpha: 0.6),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F8F0),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Color(0xFF27AE60),
                  size: 22,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.strings.locationOnMap,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F1E36),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      state.mapAddress?.isNotEmpty == true
                          ? state.mapAddress!
                          : '${state.latitude!.toStringAsFixed(5)}, ${state.longitude!.toStringAsFixed(5)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 12.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit_location_alt_outlined,
                  color: Color(0xFF005BEA),
                  size: 22,
                ),
                tooltip: 'Edit',
                onPressed: () => _openMapPicker(context, state),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 20,
                ),
                tooltip: 'Clear',
                onPressed: () {
                  context.read<AuthBloc>().add(const LocationClearedEvent());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

