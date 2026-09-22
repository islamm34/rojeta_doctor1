import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/models/hospital_service_model.dart';
import '../bloc/medical_services_bloc.dart';
import '../bloc/medical_services_event.dart';
import '../bloc/medical_services_state.dart';
import 'hospital_service_toggle.dart';
import 'medical_services_empty_state_card.dart';
import 'setup_progress_card.dart';

class MedicalServicesEmptyView extends StatelessWidget {
  final MedicalServicesState state;

  const MedicalServicesEmptyView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SetupProgressCard(completedSteps: 0, totalSteps: 3),
        SizedBox(height: 24.h),
        const MedicalServicesEmptyStateCard(),
        SizedBox(height: 24.h),
        Text(
          context.strings.enableServicesTitle,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        ...state.services.map(
          (HospitalServiceModel service) => HospitalServiceToggle(
            service: service,
            onChanged: (value) {
              context.read<MedicalServicesBloc>().add(
                ToggleServiceEvent(service.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
