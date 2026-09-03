import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../bloc/notifications/notifications_cubit.dart';
import '../../bloc/notifications/notifications_state.dart';
import 'notification_stat_card.dart';

class NotificationStatsRow extends StatelessWidget {
  const NotificationStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final totalCount = state.notifications.length;
        final unreadCount = state.unreadCount;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              Expanded(
                child: NotificationStatCard(
                  count: totalCount.toString(),
                  label: context.strings.total,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: NotificationStatCard(
                  count: unreadCount.toString(),
                  label: context.strings.unread,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
