import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class MedicalServicesAppBar extends StatelessWidget {
  const MedicalServicesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: AppColors.homeBg,
      backgroundColor: AppColors.homeBg,
      elevation: 0,
      pinned: true,
      title: Text(
        context.strings.medicalServicesTitle,
        style: context.textTheme.titleLarge?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}
