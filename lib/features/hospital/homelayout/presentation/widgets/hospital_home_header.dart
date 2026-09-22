import 'package:flutter/material.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/local/user_hive_helper.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class HospitalHomeHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final int unreadNotificationsCount;

  const HospitalHomeHeader({
    super.key,
    this.onNotificationTap,
    this.unreadNotificationsCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.paddingOf(context).top;

    final cachedUser = UserHiveHelper.getUser();
    final hospitalName = (cachedUser?.name?.isNotEmpty == true)
        ? cachedUser!.name!
        : ((cachedUser?.firstName?.isNotEmpty == true)
              ? cachedUser!.firstName!
              : context.strings.hospital);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.headerGradientStart, AppColors.headerGradientEnd],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: paddingTop + 16.h,
              left: 20.w,
              right: 20.w,
              bottom: 24.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hospital Avatar
                Container(
                  width: 52.r,
                  height: 52.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.5),
                      width: 2.w,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/hospital.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Hospital Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4.h),
                      Text(
                        context.strings.welcomeBackHospital,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        hospitalName,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                          fontSize: 12.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                // Notification Icon
                Stack(
                  clipBehavior: Clip.none,
                  children: [
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
                        onPressed:
                            onNotificationTap ??
                            () => context.pushNamed(AppRoutes.notifications),
                      ),
                    ),
                    if (unreadNotificationsCount > 0)
                      Positioned(
                        top: -4.h,
                        right: -4.w,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16.w,
                            minHeight: 16.h,
                          ),
                          child: Text(
                            unreadNotificationsCount > 99
                                ? '99+'
                                : unreadNotificationsCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 60.h,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
          ),
        ],
      ),
    );
  }
}
