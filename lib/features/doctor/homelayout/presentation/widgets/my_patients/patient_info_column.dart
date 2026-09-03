import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class PatientInfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const PatientInfoColumn({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
