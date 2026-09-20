import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import '../../../../data/models/home_visit_config_model.dart';

class ServiceAreasCard extends StatelessWidget {
  final List<ServiceAreaModel> areas;
  final VoidCallback onAddArea;
  final ValueChanged<String> onDeleteArea;

  const ServiceAreasCard({
    super.key,
    required this.areas,
    required this.onAddArea,
    required this.onDeleteArea,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.map_outlined,
                    color: const Color(0xFF0A6C74),
                    size: 20.r,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    context.strings.serviceAreas,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2D52),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: onAddArea,
                icon: Icon(
                  Icons.add_location_alt_outlined,
                  size: 16.r,
                  color: Colors.white,
                ),
                label: Text(
                  context.strings.addArea,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A2E8),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              height: 150.h,
              width: double.infinity,
              color: const Color(0xFFE2E8F0),
              child: const Icon(Icons.map, color: Color(0xFF94A3B8), size: 48),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: areas
                .map(
                  (area) => Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        right: area == areas.last ? 0 : 8.w,
                      ),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: const Color(0xFF1877F2),
                            size: 18.r,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        area.name ?? '',
                                        style: context.textTheme.titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF0F2D52),
                                            ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => onDeleteArea(area.id ?? ''),
                                      child: Icon(
                                        Icons.delete_outline,
                                        size: 16.r,
                                        color: const Color(0xFF7A8FA6),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  context.strings.radiusAndTechs(
                                    area.radiusKm ?? 0,
                                    area.techsAvailable ?? 0,
                                  ),
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF7A8FA6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
