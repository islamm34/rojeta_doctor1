import 'package:flutter/material.dart';

import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';
import '../../../../data/models/nursing_service_model.dart';
import 'nursing_service_bullet_point.dart';

class NursingServiceCard extends StatelessWidget {
  final NursingServiceModel service;

  const NursingServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.medical_services_outlined,
                    color: const Color(0xFF3B82F6),
                    size: 28.r,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              service.title ?? '',
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F2D52),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              service.durationTag ?? '',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: const Color(0xFF475569),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        service.subtitle ?? '',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (service.bulletPoints.isNotEmpty) ...[
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Wrap(
                spacing: 16.w,
                runSpacing: 8.h,
                children: service.bulletPoints
                    .where((bp) => bp.trim().isNotEmpty)
                    .map(
                      (bp) => SizedBox(
                        width: (MediaQuery.sizeOf(context).width - 72.w) / 2,
                        child: NursingServiceBulletPoint(text: bp),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
