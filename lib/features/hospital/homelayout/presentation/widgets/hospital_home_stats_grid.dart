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
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatColumn(
            context,
            title: context.strings.doctors,
            value: stats.doctors,
          ),
          _buildDivider(),
          _buildStatColumn(
            context,
            title: context.strings.todaysIncome,
            value: stats.todaysIncome,
            valueColor: Colors.orange,
          ),
          _buildDivider(),
          _buildStatColumn(
            context,
            title: context.strings.appointments,
            value: stats.appointments,
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(
    BuildContext context, {
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade500,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black87,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40.h,
      width: 1.w,
      color: Colors.grey.shade200,
    );
  }
}
