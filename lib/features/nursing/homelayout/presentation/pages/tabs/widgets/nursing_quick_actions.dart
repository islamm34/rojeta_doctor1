import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import '../../../bloc/nursing_bloc.dart';
import '../../../bloc/nursing_event.dart';
import 'nursing_action_card.dart';

class NursingQuickActions extends StatelessWidget {
  const NursingQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NursingActionCard(
          title: 'Add Service',
          icon: Icons.medical_services_outlined,
          color: const Color(0xFF3B82F6),
          onTap: () {
            context.pushNamed(
              AppRoutes.nursingAddService,
              extra: context.read<NursingBloc>(),
            );
          },
        ),
        SizedBox(width: 12.w),
        NursingActionCard(
          title: 'Add Nurse',
          icon: Icons.person_add_outlined,
          color: const Color(0xFF22C55E),
          onTap: () {
            context.pushNamed(
              AppRoutes.nursingAddNurse,
              extra: context.read<NursingBloc>(),
            );
          },
        ),
        SizedBox(width: 12.w),
        NursingActionCard(
          title: 'View Bookings',
          icon: Icons.event_note_outlined,
          color: const Color(0xFFA855F7),
          onTap: () {
            context.read<NursingBloc>().add(const ChangeNursingTabEvent(3));
          },
        ),
      ],
    );
  }
}
