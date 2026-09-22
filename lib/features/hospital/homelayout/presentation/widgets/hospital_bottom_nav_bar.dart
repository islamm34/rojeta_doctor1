import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'hospital_bottom_nav_item.dart';

class HospitalBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const HospitalBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HospitalBottomNavItem(
            index: 0,
            isSelected: selectedIndex == 0,
            icon: selectedIndex == 0 ? Icons.home : Icons.home_outlined,
            label: context.strings.home,
            onTap: onDestinationSelected,
          ),
          HospitalBottomNavItem(
            index: 1,
            isSelected: selectedIndex == 1,
            icon: selectedIndex == 1
                ? Icons.calendar_today
                : Icons.calendar_today_outlined,
            label: context.strings.appointments,
            onTap: onDestinationSelected,
          ),
          HospitalBottomNavItem(
            index: 2,
            isSelected: selectedIndex == 2,
            icon: selectedIndex == 2
                ? Icons.grid_view
                : Icons.grid_view_outlined,
            label: context.strings.depts,
            onTap: onDestinationSelected,
          ),
          HospitalBottomNavItem(
            index: 3,
            isSelected: selectedIndex == 3,
            icon: selectedIndex == 3 ? Icons.settings : Icons.settings_outlined,
            label: context.strings.settings,
            onTap: onDestinationSelected,
          ),
        ],
      ),
    );
  }
}
