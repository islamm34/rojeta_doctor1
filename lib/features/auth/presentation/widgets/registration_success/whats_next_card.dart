import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class WhatsNextCard extends StatelessWidget {
  const WhatsNextCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0), // Light orange bg
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.strings.whatsNext,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.hourglass_top, color: Colors.deepOrange, size: 20.w),
            ],
          ),
          SizedBox(height: 16.h),
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
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.brown.shade800,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
