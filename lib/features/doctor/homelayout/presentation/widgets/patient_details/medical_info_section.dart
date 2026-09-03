import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'patient_medical_info_container.dart';

class MedicalInfoSection extends StatelessWidget {
  final List<String> allergies;
  final List<String> chronicConditions;

  const MedicalInfoSection({
    super.key,
    required this.allergies,
    required this.chronicConditions,
  });

  @override
  Widget build(BuildContext context) {
    if (allergies.isEmpty && chronicConditions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.medicalInformation,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        if (allergies.isNotEmpty) ...[
          PatientMedicalInfoContainer(
            icon: Icons.warning_amber_rounded,
            title: context.strings.allergies,
            items: allergies,
            iconColor: Colors.red[700]!,
            backgroundColor: Colors.red[50]!,
            chipColor: Colors.red[200]!,
            chipTextColor: Colors.red[700]!,
          ),
          SizedBox(height: 12.h),
        ],
        if (chronicConditions.isNotEmpty) ...[
          PatientMedicalInfoContainer(
            icon: Icons.medical_services_outlined,
            title: context.strings.chronicConditions,
            items: chronicConditions,
            iconColor: Colors.deepOrange[700]!,
            backgroundColor: Colors.deepOrange[50]!,
            chipColor: Colors.deepOrange[200]!,
            chipTextColor: Colors.deepOrange[700]!,
          ),
        ],
      ],
    );
  }
}
