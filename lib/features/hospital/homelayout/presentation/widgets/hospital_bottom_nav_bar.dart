import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

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
          _buildNavItem(
            context,
            index: 0,
            icon: selectedIndex == 0 ? Icons.home : Icons.home_outlined,
            label: context.strings.home, 
          ),
          _buildNavItem(
            context,
            index: 1,
            icon: selectedIndex == 1 ? Icons.calendar_today : Icons.calendar_today_outlined,
            label: context.strings.appointments,
          ),
          _buildNavItem(
            context,
            index: 2,
            icon: selectedIndex == 2 ? Icons.grid_view : Icons.grid_view_outlined,
            label: context.strings.depts,
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
    return GestureDetector(
      onTap: () => onDestinationSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 3.h,
            width: 25.w,
            decoration: BoxDecoration(
              color: isSelected ? context.colors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          10.ver,
          Icon(
            icon,
            color: isSelected ? context.colors.primary : Colors.grey.shade600,
            size: 28.r,
          ),
          4.ver,
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: isSelected ? context.colors.primary : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
