import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../bloc/patients/patients_bloc.dart';
import '../bloc/patients/patients_event.dart';
import '../bloc/patients/patients_state.dart';
import '../widgets/patient_details/laboratory_results_section.dart';
import '../widgets/patient_details/medical_info_section.dart';
import '../widgets/patient_details/patient_header_card.dart';
import '../widgets/patient_details/visit_history_section.dart';

class PatientDetailsPage extends StatefulWidget {
  final String patientId;

  const PatientDetailsPage({super.key, required this.patientId});

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<PatientsBloc>().add(
      FetchPatientDetailsEvent(widget.patientId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.strings.patientDetails,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: BlocBuilder<PatientsBloc, PatientsState>(
        builder: (context, state) {
          if (state.status == PatientsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == PatientsStatus.failure) {
            return Center(child: Text(state.errorMessage ?? 'Error'));
          }

          final details = state.selectedPatient;
          if (details == null) {
            return const Center(child: Text('No details found.'));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PatientHeaderCard(basicInfo: details.basicInfo),
                SizedBox(height: 24.h),
                MedicalInfoSection(
                  allergies: details.allergies,
                  chronicConditions: details.chronicConditions,
                ),
                SizedBox(height: 24.h),
                VisitHistorySection(visitHistory: details.visitHistory),
                SizedBox(height: 24.h),
                LaboratoryResultsSection(results: details.labResults),
                SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
