import 'package:flutter/material.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class NotificationTipItem extends StatelessWidget {
  final String text;

  const NotificationTipItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade700,
                ),
          ),
        ),
      ],
    );
  }
}
