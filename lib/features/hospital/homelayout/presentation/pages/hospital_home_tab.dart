import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../bloc/hospital_bloc.dart';
import '../bloc/hospital_event.dart';
import '../bloc/hospital_state.dart';
import '../widgets/hospital_home_header.dart';
import '../widgets/hospital_home_stats_grid.dart';
import '../widgets/hospital_quick_actions_grid.dart';
import '../widgets/hospital_upcoming_appointments_section.dart';
import '../widgets/medical_services_banner.dart';

class HospitalHomeTab extends StatelessWidget {
  final VoidCallback? onViewAllAppointments;

  const HospitalHomeTab({super.key, this.onViewAllAppointments});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalBloc, HospitalState>(
      builder: (context, state) {
        if (state.status == HospitalStatus.loading &&
            state.dashboardData == null) {
          return const Scaffold(
            backgroundColor: AppColors.homeBg,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        final data = state.dashboardData;
        final upcomingAppointments = data?.upcomingAppointments ?? const [];
        final unreadCount = data?.unreadNotificationsCount ?? 0;

        return Scaffold(
          backgroundColor: AppColors.homeBg,
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<HospitalBloc>().add(
                const LoadHospitalDashboardEvent(),
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      HospitalHomeHeader(unreadNotificationsCount: unreadCount),
                      Positioned(
                        bottom: -40.h,
                        left: 20.w,
                        right: 20.w,
                        child: HospitalHomeStatsGrid(data: data),
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
                          appointments: upcomingAppointments,
                          onViewAllTap: onViewAllAppointments,
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
