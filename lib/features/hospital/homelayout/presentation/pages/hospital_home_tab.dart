import 'package:flutter/material.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../widgets/hospital_home_header.dart';
import '../widgets/hospital_home_stats_grid.dart';
import '../widgets/medical_services_banner.dart';
import '../widgets/hospital_quick_actions_grid.dart';
import '../widgets/hospital_upcoming_appointments_section.dart';

class HospitalHomeTab extends StatelessWidget {
  final VoidCallback? onViewAllAppointments;

  const HospitalHomeTab({super.key, this.onViewAllAppointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const HospitalHomeHeader(),
                Positioned(
                  bottom: -40.h,
                  left: 20.w,
                  right: 20.w,
                  child: const HospitalHomeStatsGrid(),
                ),
              ],
            ),
            // Space for the overlapping stats grid
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MedicalServicesBanner(
                    onManageTap: () =>
                        context.pushNamed(AppRoutes.laboratoryManagement),
                  ),
                  SizedBox(height: 28.h),
                  HospitalQuickActionsGrid(
                    onAppointmentsTap: onViewAllAppointments,
                  ),
                  SizedBox(height: 28.h),
                  HospitalUpcomingAppointmentsSection(
                    onViewAllTap: onViewAllAppointments,
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
