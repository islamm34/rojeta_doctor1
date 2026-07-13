import 'package:flutter/material.dart';
import '../../../../../features/auth/data/models/user_type_model.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import 'lab_quick_action_button.dart';

class LabQuickActionGrid extends StatelessWidget {
  final UserType userType;
  final VoidCallback onAddTest;
  final VoidCallback onManageBranch;
  final VoidCallback onHomeVisits;
  final VoidCallback onViewBookings;

  const LabQuickActionGrid({
    super.key,
    required this.userType,
    required this.onAddTest,
    required this.onManageBranch,
    required this.onHomeVisits,
    required this.onViewBookings,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.w,
      childAspectRatio: 1.2,
      children: [
        LabQuickActionButton(
          title: userType == UserType.radiologyCenter ? context.strings.addScan : context.strings.addTest,
          icon: Icons.add_box_outlined,
          backgroundColor: const Color(0xFF4A89FF),
          onTap: onAddTest,
        ),
        LabQuickActionButton(
          title: context.strings.manageBranch,
          icon: Icons.storefront_outlined,
          backgroundColor: const Color(0xFF2ECD7A),
          onTap: onManageBranch,
        ),
        LabQuickActionButton(
          title: context.strings.homeVisits,
          icon: Icons.home_outlined,
          backgroundColor: const Color(0xFFFF7E40),
          onTap: onHomeVisits,
        ),
        LabQuickActionButton(
          title: context.strings.viewBookings,
          icon: Icons.calendar_today_outlined,
          backgroundColor: const Color(0xFFAB52FF),
          onTap: onViewBookings,
        ),
      ],
    );
  }
}
