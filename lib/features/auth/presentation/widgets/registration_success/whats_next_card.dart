import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class WhatsNextCard extends StatelessWidget {
  const WhatsNextCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      context.strings.whatsNext,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF9A3412),
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text('⌛', style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: const BoxDecoration(
                  color: Color(0xFFEA580C),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.access_time, color: Colors.white, size: 20.w),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildStep(context, '1', context.strings.whatsNextStep1),
          _buildStep(context, '2', context.strings.whatsNextStep2),
          _buildStep(context, '3', context.strings.whatsNextStep3),
          _buildStep(context, '4', context.strings.whatsNextStep4),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, String number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFEA580C),
              fontSize: 12.sp,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF7C2D12),
                height: 1.4,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
