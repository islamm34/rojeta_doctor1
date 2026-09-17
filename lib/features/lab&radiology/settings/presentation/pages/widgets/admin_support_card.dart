import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class AdminSupportCard extends StatelessWidget {
  final VoidCallback onContactSupport;

  const AdminSupportCard({
    super.key,
    required this.onContactSupport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2FE),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFBAE6FD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.support_agent_outlined,
                color: const Color(0xFF0369A1),
                size: 18.r,
              ),
              SizedBox(width: 8.w),
              Text(
                'Admin Support',
                style: context.textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF0369A1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Need help with your profile or documents?\nOur support team is available 24/7.',
            style: context.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF0F2D52),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContactSupport,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1877F2),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: const Text(
                'Contact Support',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
