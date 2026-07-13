import 'package:flutter/material.dart';
import '../../data/models/specialty_model.dart';
import '../bloc/medical_services_state.dart';
import 'specialty_card.dart';

class MedicalServicesPopulatedView extends StatelessWidget {
  final MedicalServicesState state;

  const MedicalServicesPopulatedView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: state.specialties
          .map(
            (SpecialtyModel specialty) => SpecialtyCard(specialty: specialty),
          )
          .toList(),
    );
  }
}
