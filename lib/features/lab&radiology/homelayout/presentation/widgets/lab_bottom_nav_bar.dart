import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import '../../../../../../features/auth/data/models/user_type_model.dart';
import 'lab_bottom_nav_item.dart';

class LabBottomNavBar extends StatelessWidget {
  final UserType? userType;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const LabBottomNavBar({
    super.key,
    this.userType,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LabBottomNavItem(
            index: 0,
            isSelected: selectedIndex == 0,
            icon: selectedIndex == 0 ? Icons.home : Icons.home_outlined,
            label: context.strings.home,
            onSelected: onDestinationSelected,
          ),
          LabBottomNavItem(
            index: 1,
            isSelected: selectedIndex == 1,
            icon: selectedIndex == 1
                ? Icons.medical_services
                : Icons.medical_services_outlined,
            label: userType == UserType.radiologyCenter
                ? context.strings.scans
                : context.strings.tests,
            onSelected: onDestinationSelected,
          ),
          LabBottomNavItem(
            index: 2,
            isSelected: selectedIndex == 2,
            icon: selectedIndex == 2
                ? Icons.calendar_today
                : Icons.calendar_today_outlined,
            label: context.strings.booking,
            onSelected: onDestinationSelected,
          ),
          LabBottomNavItem(
            index: 3,
            isSelected: selectedIndex == 3,
            icon: selectedIndex == 3 ? Icons.settings : Icons.settings_outlined,
            label: context.strings.settings,
            onSelected: onDestinationSelected,
          ),
        ],
      ),
    );
  }
}
