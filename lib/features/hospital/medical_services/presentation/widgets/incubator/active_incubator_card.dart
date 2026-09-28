import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/hospital/medical_services/data/models/incubator_model.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class ActiveIncubatorCard extends StatelessWidget {
  final IncubatorModel incubator;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ActiveIncubatorCard({
    super.key,
    required this.incubator,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isReady = incubator.status == 'ready';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.child_care, color: Colors.blueGrey, size: 30.w),
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
                      child: Row(
                        children: [
                          Text(
                            incubator.unitId,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: isReady
                                  ? Colors.tealAccent.withValues(alpha: 0.3)
                                  : AppColors.primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              isReady
                                  ? context.strings.ready
                                  : context.strings.inUse.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: isReady
                                    ? Colors.teal
                                    : AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.grey),
                      onPressed: onEdit,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    SizedBox(width: 12.w),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: onDelete,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  incubator.wingSection,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.strings.temp,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${incubator.temperature}°C',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 32.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.strings.hum,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${incubator.humidity}%',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
