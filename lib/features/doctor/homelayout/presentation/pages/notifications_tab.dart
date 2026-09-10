import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../bloc/notifications/notifications_cubit.dart';
import '../bloc/notifications/notifications_state.dart';
import '../widgets/notifications/notifications_header.dart';
import '../widgets/notifications/notifications_filter_tabs.dart';
import '../widgets/notifications/notification_item_card.dart';
import '../widgets/notifications/notification_management_tips.dart';
import '../widgets/notifications/notification_stats_row.dart';

import '../../../../../../core/di/injector.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<NotificationsCubit>();
      return const NotificationsTabContent();
    } catch (_) {
      return BlocProvider(
        create: (context) => injector<NotificationsCubit>(),
        child: const NotificationsTabContent(),
      );
    }
  }
}

class NotificationsTabContent extends StatelessWidget {
  const NotificationsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const NotificationsHeader(),
              Positioned(
                bottom: -24.h,
                left: 0,
                right: 0,
                child: const NotificationsFilterTabs(),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state.status == NotificationsStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == NotificationsStatus.failure) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Error loading notifications',
                    ),
                  );
                }

                final list = state.filteredNotifications;

                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<NotificationsCubit>().loadNotifications();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                    itemCount: list.length + 2,
                    itemBuilder: (context, index) {
                      if (index < list.length) {
                        return NotificationItemCard(notification: list[index]);
                      } else if (index == list.length) {
                        return const NotificationManagementTips();
                      } else {
                        return const NotificationStatsRow();
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
