import 'package:flutter/material.dart';

import '../../../../../../../core/utils/screen_util_like.dart';

class NursingProfileDivider extends StatelessWidget {
  const NursingProfileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: const Color(0xFFF1F5F9),
      indent: 64.w,
    );
  }
}
