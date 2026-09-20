import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class ServiceStatusCard extends StatelessWidget {
  final bool isVisible;
  final ValueChanged<bool> onToggle;

  const ServiceStatusCard({
    super.key,
    required this.isVisible,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.serviceStatus,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2D52),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  isVisible
                      ? context.strings.serviceAvailableForPatients
                      : context.strings.serviceSuspendedForPatients,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF7A8FA6),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isVisible,
            onChanged: (val) => onToggle(val),
            activeColor: const Color(0xFFFC5600), // Orange switch
          ),
        ],
      ),
    );
  }
}
