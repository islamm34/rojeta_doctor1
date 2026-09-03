import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../bloc/homelayout_bloc.dart';
import 'home_stat_card.dart';

class HomeStatsGrid extends StatelessWidget {
  const HomeStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<HomelayoutBloc>().state.stats;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: HomeStatCard(
                icon: Icons.attach_money,
                value: stats?.totalEarnings ?? '0',
                title: context.strings.todaysIncome,
                iconColor: AppColors.incomeIcon,
                bgColor: AppColors.incomeIconBg,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: HomeStatCard(
                icon: Icons.trending_up,
                value: stats?.newRequests.toString() ?? '0',
                title: context.strings.newRequests,
                iconColor: AppColors.requestsIcon,
                bgColor: AppColors.requestsIconBg,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
