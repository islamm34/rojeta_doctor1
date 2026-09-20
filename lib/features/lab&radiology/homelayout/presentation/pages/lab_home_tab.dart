import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes/app_router.dart';
import '../../../../../core/local/user_hive_helper.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../features/auth/data/models/user_type_model.dart';
import '../bloc/lab_home_bloc.dart';
import '../bloc/lab_home_event.dart';
import '../bloc/lab_home_state.dart';
import '../widgets/lab_bookings_card.dart';
import '../widgets/lab_mini_stat_card.dart';
import '../widgets/lab_quick_action_grid.dart';
import '../widgets/lab_special_offer_card.dart';
import '../widgets/lab_upcoming_booking_card.dart';

class LabHomeTab extends StatelessWidget {
  final UserType userType;
  final VoidCallback onViewAllAppointments;

  const LabHomeTab({
    super.key,
    required this.userType,
    required this.onViewAllAppointments,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LabHomeBloc, LabHomeState>(
      builder: (context, state) {
        if (state.status == LabHomeStatus.loading &&
            state.dashboardData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == LabHomeStatus.failure &&
            state.dashboardData == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage ?? context.strings.somethingWentWrong,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LabHomeBloc>().add(
                        LoadLabHomeDataEvent(userType: userType),
                      );
                    },
                    child: Text(context.strings.retry),
                  ),
                ],
              ),
            ),
          );
        }

        final data = state.dashboardData;
        if (data == null) {
          return Center(child: Text(context.strings.noDataFound));
        }

        final cachedUser = UserHiveHelper.getUser();
        final userName = (cachedUser?.name?.isNotEmpty == true)
            ? cachedUser!.name!
            : ((cachedUser?.firstName?.isNotEmpty == true)
                  ? cachedUser!.firstName!
                  : (userType == UserType.radiologyCenter
                        ? context.strings.welcomeCityScan
                        : context.strings.welcomeCityLab));

        return RefreshIndicator(
          onRefresh: () async {
            context.read<LabHomeBloc>().add(
              LoadLabHomeDataEvent(userType: userType),
            );
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Blue gradient header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 50.h,
                    bottom: 24.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1877F2), Color(0xFF00A2E8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(24.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.2,
                            ),
                            backgroundImage:
                                (cachedUser?.image?.isNotEmpty == true)
                                ? NetworkImage(cachedUser!.image!)
                                : const NetworkImage(
                                        'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&q=80&w=200',
                                      )
                                      as ImageProvider,
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.strings.goodMorning,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                              Text(
                                userName,
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(AppRoutes.doctorConversations);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(AppRoutes.notifications);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.notifications_none_outlined,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Title
                      Text(
                        userName,
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: const Color(0xFF0F2D52),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        context.strings.whatsHappeningToday,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF7A8FA6),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Today's Bookings Card
                      LabBookingsCard(
                        count: data.todayBookings ?? 0,
                        progress: data.todayBookingsProgress ?? '',
                      ),
                      SizedBox(height: 16.h),

                      // Pending Requests & Home Visits
                      Row(
                        children: [
                          Expanded(
                            child: LabMiniStatCard(
                              title: context.strings.pendingRequests,
                              value: (data.pendingRequests ?? 0).toString(),
                              icon: Icons.assignment_outlined,
                              iconColor: const Color(0xFFFC5600),
                              iconBgColor: const Color(0xFFFFF0E8),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: LabMiniStatCard(
                              title: context.strings.homeVisits,
                              value: (data.homeVisits ?? 0).toString(),
                              icon: Icons.home_work_outlined,
                              iconColor: const Color(0xFF1877F2),
                              iconBgColor: const Color(0xFFEBF3FF),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Quick Actions
                      Text(
                        context.strings.quickActions,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF0F2D52),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      LabQuickActionGrid(
                        userType: userType,
                        onAddTest: () {
                          context.pushNamed(
                            AppRoutes.addLabService,
                            extra: userType,
                          );
                        },
                        onManageBranch: () {
                          context.pushNamed(
                            AppRoutes.manageBranch,
                            extra: userType,
                          );
                        },
                        onHomeVisits: () {
                          context.pushNamed(
                            AppRoutes.homeVisits,
                            extra: userType,
                          );
                        },
                        onViewBookings: onViewAllAppointments,
                      ),
                      SizedBox(height: 24.h),

                      // Upcoming Booking Header & Card
                      if (data.upcomingBooking != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.strings.upcomingBooking,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF0F2D52),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: onViewAllAppointments,
                              child: Text(
                                context.strings.viewAll,
                                style: const TextStyle(
                                  color: Color(0xFF1877F2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        LabUpcomingBookingCard(
                          booking: data.upcomingBooking!,
                          onTap: onViewAllAppointments,
                        ),
                        SizedBox(height: 24.h),
                      ],

                      // Special Offers Header & Card
                      if (data.specialOffer != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.strings.specialOffers,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF0F2D52),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(
                              Icons.card_giftcard_outlined,
                              color: Color(0xFF1877F2),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        LabSpecialOfferCard(
                          offer: data.specialOffer!,
                          onUpgrade: () {
                            context.pushNamed(AppRoutes.marketingPackages);
                          },
                        ),
                        SizedBox(height: 12.h),

                        // Dots indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 24.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1877F2),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            ...List.generate(
                              3,
                              (index) => Container(
                                width: 6.w,
                                height: 6.h,
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFCBD5E1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
