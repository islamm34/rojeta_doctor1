import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/mocks/doctor_mock_data.dart';
import 'home_stat_card.dart';

class HomeStatsGrid extends StatelessWidget {
  const HomeStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = DoctorMockData.stats;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: HomeStatCard(
                icon: Icons.access_time_filled,
                value: stats.completedAppointments.toString(),
                title: context.strings.completed,
                iconColor: AppColors.completedIcon,
                bgColor: AppColors.completedIconBg,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: HomeStatCard(
                icon: Icons.people_outline,
                value: stats.pendingRequests.toString(),
                title: context.strings.pending,
                iconColor: AppColors.pendingIcon,
                bgColor: AppColors.pendingIconBg,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: HomeStatCard(
                icon: Icons.attach_money,
                value: '\$ ${stats.totalEarnings}',
                title: context.strings.todaysIncome,
                iconColor: AppColors.incomeIcon,
                bgColor: AppColors.incomeIconBg,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: HomeStatCard(
                icon: Icons.trending_up,
                value: stats.newRequests.toString(),
                title: context.strings.newRequests,
                iconColor: AppColors.requestsIcon,
                bgColor: AppColors.requestsIconBg,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
