import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/presentation/widgets/home_stat_card.dart';
import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../bloc/homelayout_bloc.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const HomeHeader({super.key, this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomelayoutBloc>().state;
    final profile = state.profileSummary;
    final stats = state.stats;
    final paddingTop = MediaQuery.paddingOf(context).top;

    final String doctorName = profile?.name.isNotEmpty == true
        ? profile!.name
        : context.strings.doctor;
    final String doctorSpecialty = profile?.specialty ?? '';
    final String? imageUrl = profile?.imageUrl;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: paddingTop + 16.h,
        left: 20.w,
        right: 20.w,
        bottom: 6.h,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.headerGradientStart, AppColors.headerGradientEnd],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Profile Info & Action Icons
          Row(
            children: [
              // Doctor Avatar
              CircleAvatar(
                radius: 26.r,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                backgroundImage: imageUrl != null && imageUrl.startsWith('http')
                    ? NetworkImage(imageUrl)
                    : null,
                child: imageUrl == null || !imageUrl.startsWith('http')
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
              ),
              SizedBox(width: 12.w),
              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.strings.welcomeBack,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      doctorName,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                    if (doctorSpecialty.isNotEmpty)
                      Text(
                        doctorSpecialty,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.white60,
                          fontSize: 12.sp,
                        ),
                      ),
                  ],
                ),
              ),
              // Chat / Messages Icon
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.pushNamed(AppRoutes.doctorConversations);
                  },
                ),
              ),
              SizedBox(width: 10.w),
              // Notification Icon
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                  ),
                  onPressed: onNotificationTap ?? () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          // Banner Card: Today's Appointments
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.strings.todaysAppointments,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      stats?.todayAppointments.toString() ?? '0',
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.sp,
                      ),
                    ),
                  ],
                ),
                // Calendar icon container
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 26.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: HomeStatCard(
                  icon: Icons.access_time_filled,
                  value: stats?.completedAppointments.toString() ?? '0',
                  title: context.strings.completed,
                  iconColor: AppColors.completedIcon,
                  bgColor: AppColors.completedIconBg,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: HomeStatCard(
                  icon: Icons.people_outline,
                  value: stats?.pendingRequests.toString() ?? '0',
                  title: context.strings.pending,
                  iconColor: AppColors.pendingIcon,
                  bgColor: AppColors.pendingIconBg,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
