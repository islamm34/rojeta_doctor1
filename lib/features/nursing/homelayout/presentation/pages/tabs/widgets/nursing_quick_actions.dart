import 'package:flutter/material.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class NursingQuickActions extends StatelessWidget {
  const NursingQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionCard(
          context: context,
          title: 'Add Service',
          icon: Icons.medical_services_outlined,
          color: const Color(0xFF3B82F6), // Blue
          onTap: () {
            context.pushNamed(AppRoutes.nursingAddService);
          },
        ),
        SizedBox(width: 12.w),
        _buildActionCard(
          context: context,
          title: 'Add Nurse',
          icon: Icons.person_add_outlined,
          color: const Color(0xFF22C55E), // Green
          onTap: () {},
        ),
        SizedBox(width: 12.w),
        _buildActionCard(
          context: context,
          title: 'View Bookings',
          icon: Icons.event_note_outlined,
          color: const Color(0xFFA855F7), // Purple
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 28.r),
              SizedBox(height: 12.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
