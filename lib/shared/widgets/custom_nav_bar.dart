import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final int? badgeCount;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.badgeCount,
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
            icon: selectedIndex == 1
                ? Icons.calendar_today
                : Icons.calendar_today_outlined,
            label: context.strings.appointments,
          ),
          _buildNavItem(
            context,
            index: 2,
            icon: selectedIndex == 2
                ? Icons.notifications
                : Icons.notifications_none_outlined,
            label: context.strings.notifications,
            badgeCount: badgeCount,
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
    int? badgeCount,
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
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? context.colors.primary
                    : Colors.grey.shade600,
                size: 28.r,
              ),
              if (badgeCount != null && badgeCount > 0)
                PositionedDirectional(
                  end: -4.w,
                  top: -4.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: badgeCount > 9 ? 4.w : 2.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.error,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16.w,
                      minHeight: 16.h,
                    ),
                    child: Center(
                      child: Text(
                        badgeCount > 99 ? '99+' : badgeCount.toString(),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colors.onError,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
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
