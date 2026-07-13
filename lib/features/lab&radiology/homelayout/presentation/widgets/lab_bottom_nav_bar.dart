import 'package:flutter/material.dart';
import '../../../../../features/auth/data/models/user_type_model.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class LabBottomNavBar extends StatelessWidget {
  final UserType userType;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const LabBottomNavBar({
    super.key,
    required this.userType,
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
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            index: 0,
            icon: selectedIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
            label: context.strings.home,
          ),
          _buildNavItem(
            context,
            index: 1,
            icon: userType == UserType.radiologyCenter
                ? (selectedIndex == 1 ? Icons.medical_services : Icons.medical_services_outlined)
                : (selectedIndex == 1 ? Icons.science : Icons.science_outlined),
            label: userType == UserType.radiologyCenter ? context.strings.services : context.strings.tests,
          ),
          _buildNavItem(
            context,
            index: 2,
            icon: selectedIndex == 2 ? Icons.calendar_month : Icons.calendar_month_outlined,
            label: context.strings.booking,
          ),
          _buildNavItem(
            context,
            index: 3,
            icon: selectedIndex == 3 ? Icons.settings : Icons.settings_outlined,
            label: context.strings.settings,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = selectedIndex == index;
    // Blue color from mockup (Color(0xFF1877F2))
    final activeColor = const Color(0xFF1877F2);
    final inactiveColor = Colors.grey.shade400;

    return GestureDetector(
      onTap: () => onDestinationSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? activeColor : inactiveColor,
            size: 26.r,
          ),
          4.ver,
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: isSelected ? activeColor : inactiveColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
