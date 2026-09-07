import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../widgets/home_header.dart';
import '../widgets/home_stats_grid.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/special_offers_section.dart';
import '../widgets/upcoming_appointments_section.dart';
import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback? onViewAllAppointments;
  final VoidCallback? onNotificationTap;

  const HomeTab({
    super.key,
    this.onViewAllAppointments,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(onNotificationTap: onNotificationTap),
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                bottom: 24.h,
                top: 6.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeStatsGrid(),
                  SizedBox(height: 28.h),
                  QuickActionsGrid(
                    onTapAppointments: onViewAllAppointments,
                    onTapSchedule: () =>
                        context.pushNamed(AppRoutes.scheduleManagement),
                    onTapPatients: () =>
                        context.pushNamed(AppRoutes.myPatients),
                    onTapFinancial: () =>
                        context.pushNamed(AppRoutes.financialManagement),
                  ),
                  SpecialOffersSection(
                    onUpgradeTap: () =>
                        context.pushNamed(AppRoutes.marketingPackages),
                  ),
                  SizedBox(height: 28.h),
                  UpcomingAppointmentsSection(
                    onViewAllTap: onViewAllAppointments,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
