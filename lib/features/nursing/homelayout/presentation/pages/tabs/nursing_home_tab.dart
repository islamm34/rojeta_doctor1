import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import '../../bloc/nursing_bloc.dart';
import '../../bloc/nursing_state.dart';
import 'widgets/nursing_dashboard_header.dart';
import 'widgets/nursing_stat_cards.dart';
import 'widgets/nursing_quick_actions.dart';
import 'widgets/nursing_upcoming_bookings.dart';

class NursingHomeTab extends StatelessWidget {
  const NursingHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NursingBloc, NursingState>(
      builder: (context, state) {
        if (state.dashboardData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = state.dashboardData!;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NursingDashboardHeader(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, Graceful Care',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F2D52),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Here's what's happening today.",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    NursingStatCards(data: data),
                    SizedBox(height: 24.h),
                    Text(
                      'Quick Actions',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F2D52),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const NursingQuickActions(),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upcoming Bookings',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F2D52),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View All',
                            style: context.textTheme.titleSmall?.copyWith(
                              color: const Color(0xFF0369A1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    NursingUpcomingBookings(bookings: data.upcomingBookings),
                    SizedBox(height: 80.h), // Padding for bottom nav
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
