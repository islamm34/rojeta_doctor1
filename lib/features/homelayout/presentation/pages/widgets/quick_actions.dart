import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.quickActions,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        16.ver,
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 1.3,
          children: [
            _buildActionCard(
              title: strings.addTest,
              icon: Icons.add_box_outlined,
              backgroundColor: const Color(0xFF4285F4),
              textColor: Colors.white,
            ),
            _buildActionCard(
              title: strings.manageBranch,
              icon: Icons.storefront_outlined,
              backgroundColor: const Color(0xFF34A853),
              textColor: Colors.white,
            ),
            _buildActionCard(
              title: strings.homeVisits,
              icon: Icons.home_outlined,
              backgroundColor: const Color(0xFFFBBC05),
              textColor: Colors.white,
            ),
            _buildActionCard(
              title: strings.viewBookings,
              icon: Icons.calendar_month_outlined,
              backgroundColor: const Color(0xFFA142F4),
              textColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: textColor,
            size: 32.r,
          ),
          12.ver,
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
