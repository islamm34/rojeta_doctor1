import 'package:flutter/material.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/shared/widgets/quick_action_card.dart';

class QuickActionsGrid extends StatelessWidget {
  final VoidCallback? onTapAppointments;
  final VoidCallback? onTapSchedule;
  final VoidCallback? onTapPatients;
  final VoidCallback? onTapFinancial;

  const QuickActionsGrid({
    super.key,
    this.onTapAppointments,
    this.onTapSchedule,
    this.onTapPatients,
    this.onTapFinancial,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.quickActions,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                icon: Icons.calendar_today_outlined,
                title: context.strings.appointments,
                subtitle: context.strings.manageBookings,
                backgroundColor: AppColors.actionAppointments,
                onTap: onTapAppointments ?? () {},
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: QuickActionCard(
                icon: Icons.access_time,
                title: context.strings.schedule,
                subtitle: context.strings.setAvailability,
                backgroundColor: AppColors.actionSchedule,
                onTap: onTapSchedule ?? () {},
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                icon: Icons.people_outline,
                title: context.strings.patients,
                subtitle: context.strings.viewRecords,
                backgroundColor: AppColors.actionPatients,
                onTap: onTapPatients ?? () {},
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: QuickActionCard(
                icon: Icons.attach_money,
                title: context.strings.financial,
                subtitle: context.strings.viewIncome,
                backgroundColor: AppColors.actionFinancial,
                onTap: onTapFinancial ?? () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
