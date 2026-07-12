import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/mocks/hospital_mock_data.dart';

class HospitalHomeStatsGrid extends StatelessWidget {
  const HospitalHomeStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = HospitalMockData.stats;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatCard(
            context,
            icon: Icons.medical_services_outlined,
            title: context.strings.doctors,
            value: stats.doctors,
          ),
          SizedBox(width: 8.w),
          _buildStatCard(
            context,
            icon: Icons.payments_outlined,
            title: context.strings.todaysIncome,
            value: stats.todaysIncome,
          ),
          SizedBox(width: 8.w),
          _buildStatCard(
            context,
            icon: Icons.calendar_month_outlined,
            title: context.strings.appointments,
            value: stats.appointments,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF1F5C67), size: 28.sp),
            SizedBox(height: 12.h),
            Text(
              title,
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
                fontSize: 11.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1D1E),
                fontSize: 14.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
