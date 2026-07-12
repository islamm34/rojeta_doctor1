import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/doctor_appointment_model.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../widgets/medical_consultation/consultation_patient_info_card.dart';
import '../widgets/medical_consultation/start_consultation_button.dart';
import '../widgets/medical_consultation/consultation_form_section.dart';
import '../widgets/medical_consultation/consultation_action_buttons.dart';

class MedicalConsultationPage extends StatelessWidget {
  final DoctorAppointmentModel appointment;

  const MedicalConsultationPage({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.strings.medicalConsultation,
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConsultationPatientInfoCard(appointment: appointment),
            SizedBox(height: 16.h),
            const StartConsultationButton(),
            SizedBox(height: 16.h),
            const ConsultationFormSection(),
            SizedBox(height: 24.h),
            const ConsultationActionButtons(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
