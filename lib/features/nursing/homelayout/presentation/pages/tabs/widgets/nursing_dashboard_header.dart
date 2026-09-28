import 'package:flutter/material.dart';

import '../../../../../../../config/routes/app_router.dart';
import '../../../../../../../core/local/user_hive_helper.dart';
import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';

class NursingDashboardHeader extends StatelessWidget {
  const NursingDashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final cachedUser = UserHiveHelper.getUser();
    final nurseName = (cachedUser?.name?.isNotEmpty == true)
        ? cachedUser!.name!
        : ((cachedUser?.firstName?.isNotEmpty == true)
              ? cachedUser!.firstName!
              : strings.nursingCare);

    return Container(
      padding: EdgeInsets.only(
        top: 60.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.white24,
            child: Icon(Icons.local_hospital, color: Colors.white, size: 28.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.goodMorning,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                Text(
                  nurseName,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.pushNamed(AppRoutes.doctorConversations),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () => context.pushNamed(AppRoutes.notifications),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_none, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
