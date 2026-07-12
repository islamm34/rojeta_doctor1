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

  const HomeTab({super.key, this.onViewAllAppointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
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
                  SizedBox(height: 28.h),
                  const SpecialOffersSection(),
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
