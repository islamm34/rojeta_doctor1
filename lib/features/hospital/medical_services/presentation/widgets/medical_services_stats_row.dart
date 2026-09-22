import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../bloc/medical_services_state.dart';
import 'medical_services_stat_card.dart';

class MedicalServicesStatsRow extends StatelessWidget {
  final MedicalServicesState state;

  const MedicalServicesStatsRow({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MedicalServicesStatCard(
            title: context.strings.activeSpecialties,
            value: state.activeSpecialtiesCount.toString(),
            color: const Color(0xFFFFF9E5),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: MedicalServicesStatCard(
            title: context.strings.totalStaff,
            value: state.totalStaffCount.toString(),
            color: const Color(0xFFE5F5E9),
          ),
        ),
      ],
    );
  }
}
