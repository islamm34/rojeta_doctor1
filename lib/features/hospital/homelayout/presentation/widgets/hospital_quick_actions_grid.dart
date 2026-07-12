import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/quick_action_card.dart';

class HospitalQuickActionsGrid extends StatelessWidget {
  const HospitalQuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.quickActions,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 16.h),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 1.1,
          children: [
            QuickActionCard(
              title: context.strings.appointments,
              subtitle: 'Manage bookings', // Not localized strictly for mock
              icon: Icons.calendar_today_outlined,
              backgroundColor: AppColors.actionAppointments,
              onTap: () {},
            ),
            QuickActionCard(
              title: context.strings.addSpecialty,
              subtitle: context.strings.addNewSpecialty,
              icon: Icons.add_circle_outline,
              backgroundColor: AppColors.actionSchedule,
              onTap: () {},
            ),
            QuickActionCard(
              title: context.strings.addDoctor,
              subtitle: context.strings.addNewDoctor,
              icon: Icons.person_add_alt_1_outlined,
              backgroundColor: AppColors.actionPatients,
              onTap: () {},
            ),
            QuickActionCard(
              title: context.strings.viewEarnings,
              subtitle: context.strings.viewEarnings,
              icon: Icons.account_balance_wallet_outlined,
              backgroundColor: AppColors.actionFinancial,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
