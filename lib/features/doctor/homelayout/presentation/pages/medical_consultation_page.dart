import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/file_picker_helper.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/consultation_request_model.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/doctor_appointment_model.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../bloc/medical_consultation/medical_consultation_bloc.dart';
import '../bloc/medical_consultation/medical_consultation_event.dart';
import '../bloc/medical_consultation/medical_consultation_state.dart';
import '../widgets/medical_consultation/consultation_action_buttons.dart';
import '../widgets/medical_consultation/consultation_form_section.dart';
import '../widgets/medical_consultation/consultation_patient_info_card.dart';
import '../widgets/medical_consultation/start_consultation_button.dart';

class MedicalConsultationPage extends StatefulWidget {
  final DoctorAppointmentModel appointment;

  const MedicalConsultationPage({
    super.key,
    required this.appointment,
  });

  @override
  State<MedicalConsultationPage> createState() =>
      _MedicalConsultationPageState();
}

class _MedicalConsultationPageState extends State<MedicalConsultationPage> {
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _labTestsController = TextEditingController();
  final TextEditingController _radiologyTestsController =
      TextEditingController();
  final TextEditingController _followUpDateController = TextEditingController();
  PlatformFile? _pickedPdf;

  @override
  void dispose() {
    _diagnosisController.dispose();
    _medicationController.dispose();
    _labTestsController.dispose();
    _radiologyTestsController.dispose();
    _followUpDateController.dispose();
    super.dispose();
  }

  Future<void> _pickPdf() async {
    final file = await FilePickerHelper.pickPdf();
    if (!mounted) return;
    if (file != null) {
      setState(() {
        _pickedPdf = file;
      });
    }
  }

  void _removePdf() {
    setState(() {
      _pickedPdf = null;
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _followUpDateController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  void _submitConsultation() {
    final request = ConsultationRequestModel(
      appointmentId: int.tryParse(widget.appointment.id) ?? 0,
      diagnosis: _diagnosisController.text.trim(),
      medicationDetails: _medicationController.text.trim(),
      laboratoryTests: _labTestsController.text.trim(),
      radiologyTests: _radiologyTestsController.text.trim(),
      followUpDate: _followUpDateController.text.trim().isNotEmpty
          ? _followUpDateController.text.trim()
          : null,
      prescriptionPdfPath: _pickedPdf?.path,
    );

    context.read<MedicalConsultationBloc>().add(
          SubmitConsultationEvent(request),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicalConsultationBloc, MedicalConsultationState>(
      listener: (context, state) {
        if (state.status == MedicalConsultationStatus.success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final isLoading = state.status == MedicalConsultationStatus.loading;

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
                ConsultationPatientInfoCard(appointment: widget.appointment),
                SizedBox(height: 16.h),
                const StartConsultationButton(),
                SizedBox(height: 16.h),
                ConsultationFormSection(
                  diagnosisController: _diagnosisController,
                  medicationController: _medicationController,
                  labTestsController: _labTestsController,
                  radiologyTestsController: _radiologyTestsController,
                  followUpDateController: _followUpDateController,
                  pickedPdf: _pickedPdf,
                  onPickPdf: _pickPdf,
                  onRemovePdf: _removePdf,
                  onPickDate: _pickDate,
                ),
                SizedBox(height: 24.h),
                ConsultationActionButtons(
                  isLoading: isLoading,
                  onSaveDraft: () {
                    // Draft locally if needed
                  },
                  onComplete: _submitConsultation,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
