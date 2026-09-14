import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/file_picker_helper.dart';
import 'package:rojeta_doctor/core/utils/image_picker_helper.dart';
import 'package:rojeta_doctor/core/utils/snackbar_helper.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/consultation_request_model.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/doctor_appointment_model.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../data/datasources/local/consultation_draft_local_data_source.dart';
import '../bloc/medical_consultation/medical_consultation_bloc.dart';
import '../bloc/medical_consultation/medical_consultation_event.dart';
import '../bloc/medical_consultation/medical_consultation_state.dart';
import '../widgets/medical_consultation/consultation_action_buttons.dart';
import '../widgets/medical_consultation/consultation_form_section.dart';
import '../widgets/medical_consultation/consultation_patient_info_card.dart';
import '../widgets/medical_consultation/start_consultation_button.dart';

class MedicalConsultationPage extends StatefulWidget {
  final DoctorAppointmentModel appointment;

  const MedicalConsultationPage({super.key, required this.appointment});

  @override
  State<MedicalConsultationPage> createState() =>
      _MedicalConsultationPageState();
}

class _MedicalConsultationPageState extends State<MedicalConsultationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _labTestsController = TextEditingController();
  final TextEditingController _radiologyTestsController =
      TextEditingController();
  final TextEditingController _followUpDateController = TextEditingController();
  PlatformFile? _pickedPdf;
  PlatformFile? _pickedLabDocument;
  PlatformFile? _pickedRadiologyDocument;
  final List<String> _medicalNotesImages = [];
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool _isConsultationStarted = false;
  bool _isSavingDraft = false;
  bool _isLoadingDraft = false;

  @override
  void initState() {
    super.initState();
    _loadDraft();
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
    _medicationController.dispose();
    _labTestsController.dispose();
    _radiologyTestsController.dispose();
    _followUpDateController.dispose();
    super.dispose();
  }

  Future<void> _loadDraft() async {
    setState(() {
      _isLoadingDraft = true;
    });

    try {
      final draft = await ConsultationDraftLocalDataSource.getDraft(
        widget.appointment.id,
      );
      if (!mounted || draft == null) return;

      setState(() {
        if (draft.diagnosis != null && draft.diagnosis!.isNotEmpty) {
          _diagnosisController.text = draft.diagnosis!;
        }
        if (draft.medicationDetails != null &&
            draft.medicationDetails!.isNotEmpty) {
          _medicationController.text = draft.medicationDetails!;
        }
        if (draft.laboratoryTests != null &&
            draft.laboratoryTests!.isNotEmpty) {
          _labTestsController.text = draft.laboratoryTests!;
        }
        if (draft.radiologyTests != null && draft.radiologyTests!.isNotEmpty) {
          _radiologyTestsController.text = draft.radiologyTests!;
        }
        if (draft.followUpDate != null && draft.followUpDate!.isNotEmpty) {
          _followUpDateController.text = draft.followUpDate!;
        }
        _isConsultationStarted = draft.isConsultationStarted;

        if (draft.prescriptionPdfPath != null) {
          final file = File(draft.prescriptionPdfPath!);
          if (file.existsSync()) {
            _pickedPdf = PlatformFile(
              name: draft.prescriptionPdfName ?? file.uri.pathSegments.last,
              path: draft.prescriptionPdfPath,
              size: file.lengthSync(),
            );
          }
        }

        if (draft.laboratoryTestsDocumentPath != null) {
          final file = File(draft.laboratoryTestsDocumentPath!);
          if (file.existsSync()) {
            _pickedLabDocument = PlatformFile(
              name:
                  draft.laboratoryTestsDocumentName ??
                  file.uri.pathSegments.last,
              path: draft.laboratoryTestsDocumentPath,
              size: file.lengthSync(),
            );
          }
        }

        if (draft.radiologyTestsDocumentPath != null) {
          final file = File(draft.radiologyTestsDocumentPath!);
          if (file.existsSync()) {
            _pickedRadiologyDocument = PlatformFile(
              name:
                  draft.radiologyTestsDocumentName ??
                  file.uri.pathSegments.last,
              path: draft.radiologyTestsDocumentPath,
              size: file.lengthSync(),
            );
          }
        }

        _medicalNotesImages.clear();
        for (final imgPath in draft.medicalNotesImagePaths) {
          if (File(imgPath).existsSync()) {
            _medicalNotesImages.add(imgPath);
          }
        }
      });
    } catch (e, st) {
      log('Error loading consultation draft: $e\n$st');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingDraft = false;
        });
      }
    }
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

  Future<void> _pickMedicalNoteImages() async {
    final images = await ImagePickerHelper.pickMultipleImages();
    if (!mounted) return;
    if (images.isNotEmpty) {
      setState(() {
        for (final img in images) {
          if (!_medicalNotesImages.contains(img.path)) {
            _medicalNotesImages.add(img.path);
          }
        }
      });
    }
  }

  void _removeMedicalNoteImage(int index) {
    if (index >= 0 && index < _medicalNotesImages.length) {
      setState(() {
        _medicalNotesImages.removeAt(index);
      });
    }
  }

  Future<void> _pickLabDocument() async {
    final file = await FilePickerHelper.pickDocument();
    if (!mounted) return;
    if (file != null) {
      setState(() {
        _pickedLabDocument = file;
      });
    }
  }

  void _removeLabDocument() {
    setState(() {
      _pickedLabDocument = null;
    });
  }

  Future<void> _pickRadiologyDocument() async {
    final file = await FilePickerHelper.pickDocument();
    if (!mounted) return;
    if (file != null) {
      setState(() {
        _pickedRadiologyDocument = file;
      });
    }
  }

  void _removeRadiologyDocument() {
    setState(() {
      _pickedRadiologyDocument = null;
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

  void _clearDate() {
    setState(() {
      _followUpDateController.clear();
    });
  }

  Future<void> _saveDraft() async {
    if (_isSavingDraft) return;

    setState(() {
      _isSavingDraft = true;
    });

    try {
      final savedDraft = await ConsultationDraftLocalDataSource.saveDraft(
        appointmentId: widget.appointment.id,
        diagnosis: _diagnosisController.text.trim(),
        medicationDetails: _medicationController.text.trim(),
        laboratoryTests: _labTestsController.text.trim(),
        radiologyTests: _radiologyTestsController.text.trim(),
        followUpDate: _followUpDateController.text.trim(),
        isConsultationStarted: _isConsultationStarted,
        pickedPdf: _pickedPdf,
        pickedLabDocument: _pickedLabDocument,
        pickedRadiologyDocument: _pickedRadiologyDocument,
        medicalNotesImages: _medicalNotesImages,
      );

      if (!mounted) return;

      setState(() {
        if (savedDraft.prescriptionPdfPath != null && _pickedPdf != null) {
          _pickedPdf = PlatformFile(
            name: _pickedPdf!.name,
            path: savedDraft.prescriptionPdfPath,
            size: _pickedPdf!.size,
          );
        }
        if (savedDraft.laboratoryTestsDocumentPath != null &&
            _pickedLabDocument != null) {
          _pickedLabDocument = PlatformFile(
            name: _pickedLabDocument!.name,
            path: savedDraft.laboratoryTestsDocumentPath,
            size: _pickedLabDocument!.size,
          );
        }
        if (savedDraft.radiologyTestsDocumentPath != null &&
            _pickedRadiologyDocument != null) {
          _pickedRadiologyDocument = PlatformFile(
            name: _pickedRadiologyDocument!.name,
            path: savedDraft.radiologyTestsDocumentPath,
            size: _pickedRadiologyDocument!.size,
          );
        }
        _medicalNotesImages.clear();
        _medicalNotesImages.addAll(savedDraft.medicalNotesImagePaths);
      });

      SnackbarHelper.showSuccess(
        context,
        message: context.strings.draftSavedSuccessfully,
      );
    } catch (e, st) {
      log('Error saving consultation draft: $e\n$st');
      if (!mounted) return;
      SnackbarHelper.showError(
        context,
        message: context.strings.somethingWentWrong,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSavingDraft = false;
        });
      }
    }
  }

  void _submitConsultation() {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
      SnackbarHelper.showError(
        context,
        message: context.strings.enterDiagnosis,
      );
      return;
    }

    final appointmentId = int.tryParse(widget.appointment.id);
    if (appointmentId == null || appointmentId <= 0) {
      SnackbarHelper.showError(
        context,
        message: context.strings.somethingWentWrong,
      );
      return;
    }

    final request = ConsultationRequestModel(
      appointmentId: appointmentId,
      diagnosis: _diagnosisController.text.trim(),
      medicationDetails: _medicationController.text.trim().isNotEmpty
          ? _medicationController.text.trim()
          : null,
      laboratoryTests: _labTestsController.text.trim().isNotEmpty
          ? _labTestsController.text.trim()
          : null,
      radiologyTests: _radiologyTestsController.text.trim().isNotEmpty
          ? _radiologyTestsController.text.trim()
          : null,
      followUpDate: _followUpDateController.text.trim().isNotEmpty
          ? _followUpDateController.text.trim()
          : null,
      prescriptionPdfPath: _pickedPdf?.path,
      medicalNotesImagePaths: _medicalNotesImages.isNotEmpty
          ? List.unmodifiable(_medicalNotesImages)
          : null,
      laboratoryTestsDocumentPath: _pickedLabDocument?.path,
      radiologyTestsDocumentPath: _pickedRadiologyDocument?.path,
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
          ConsultationDraftLocalDataSource.clearDraft(widget.appointment.id);
          Navigator.of(context).pop(true);
        } else if (state.status == MedicalConsultationStatus.failure) {
          SnackbarHelper.showError(
            context,
            message: state.errorMessage ?? context.strings.somethingWentWrong,
          );
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
          body: _isLoadingDraft
              ? const Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  autovalidateMode: _autoValidateMode,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ConsultationPatientInfoCard(
                          appointment: widget.appointment,
                        ),
                        SizedBox(height: 16.h),
                        StartConsultationButton(
                          isInProgress: _isConsultationStarted,
                          onPressed: () {
                            setState(() {
                              _isConsultationStarted = !_isConsultationStarted;
                            });
                          },
                        ),
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
                          medicalNotesImages: _medicalNotesImages,
                          onAddMedicalNoteImage: _pickMedicalNoteImages,
                          onRemoveMedicalNoteImage: _removeMedicalNoteImage,
                          pickedLabDocument: _pickedLabDocument,
                          onPickLabDocument: _pickLabDocument,
                          onRemoveLabDocument: _removeLabDocument,
                          pickedRadiologyDocument: _pickedRadiologyDocument,
                          onPickRadiologyDocument: _pickRadiologyDocument,
                          onRemoveRadiologyDocument: _removeRadiologyDocument,
                          onPickDate: _pickDate,
                          onClearDate: _clearDate,
                          diagnosisValidator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.strings.fieldRequired;
                            }
                            return null;
                          },
                          autovalidateMode: _autoValidateMode,
                        ),
                        SizedBox(height: 24.h),
                        ConsultationActionButtons(
                          isLoading: isLoading,
                          isSavingDraft: _isSavingDraft,
                          onSaveDraft: _saveDraft,
                          onComplete: _submitConsultation,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
