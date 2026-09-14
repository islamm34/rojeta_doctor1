import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import 'consultation_section_card.dart';
import 'medical_notes_section_content.dart';
import 'picked_file_chip.dart';

class ConsultationFormSection extends StatelessWidget {
  final TextEditingController diagnosisController;
  final TextEditingController medicationController;
  final TextEditingController labTestsController;
  final TextEditingController radiologyTestsController;
  final TextEditingController followUpDateController;
  final PlatformFile? pickedPdf;
  final VoidCallback onPickPdf;
  final VoidCallback onRemovePdf;
  final List<String> medicalNotesImages;
  final VoidCallback onAddMedicalNoteImage;
  final void Function(int index) onRemoveMedicalNoteImage;
  final PlatformFile? pickedLabDocument;
  final VoidCallback onPickLabDocument;
  final VoidCallback onRemoveLabDocument;
  final PlatformFile? pickedRadiologyDocument;
  final VoidCallback onPickRadiologyDocument;
  final VoidCallback onRemoveRadiologyDocument;
  final VoidCallback onPickDate;
  final VoidCallback? onClearDate;
  final String? Function(String?)? diagnosisValidator;
  final AutovalidateMode? autovalidateMode;

  const ConsultationFormSection({
    super.key,
    required this.diagnosisController,
    required this.medicationController,
    required this.labTestsController,
    required this.radiologyTestsController,
    required this.followUpDateController,
    this.pickedPdf,
    required this.onPickPdf,
    required this.onRemovePdf,
    required this.medicalNotesImages,
    required this.onAddMedicalNoteImage,
    required this.onRemoveMedicalNoteImage,
    this.pickedLabDocument,
    required this.onPickLabDocument,
    required this.onRemoveLabDocument,
    this.pickedRadiologyDocument,
    required this.onPickRadiologyDocument,
    required this.onRemoveRadiologyDocument,
    required this.onPickDate,
    this.onClearDate,
    this.diagnosisValidator,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConsultationSectionCard(
          icon: Icons.description_outlined,
          title: context.strings.diagnosis,
          child: CustomTextField(
            controller: diagnosisController,
            hintText: context.strings.enterDiagnosis,
            maxLines: 4,
            borderRadius: 12.r,
            validator: diagnosisValidator,
            autovalidateMode: autovalidateMode,
          ),
        ),
        SizedBox(height: 16.h),
        ConsultationSectionCard(
          title: context.strings.medicalNotes,
          titleTrailing: TextButton.icon(
            onPressed: onAddMedicalNoteImage,
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              size: 16.sp,
              color: Colors.blue,
            ),
            label: Text(
              context.strings.addPhoto,
              style: TextStyle(fontSize: 12.sp, color: Colors.blue),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.withValues(alpha: 0.1),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          child: MedicalNotesSectionContent(
            images: medicalNotesImages,
            onAddImage: onAddMedicalNoteImage,
            onRemoveImage: onRemoveMedicalNoteImage,
          ),
        ),
        SizedBox(height: 16.h),
        ConsultationSectionCard(
          title: context.strings.prescription,
          titleTrailing: TextButton.icon(
            onPressed: onPickPdf,
            icon: Icon(Icons.upload_file, size: 16.sp, color: Colors.blue),
            label: Text(
              context.strings.uploadPdf,
              style: TextStyle(fontSize: 12.sp, color: Colors.blue),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.withValues(alpha: 0.1),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: medicationController,
                hintText: context.strings.medicationDetails,
                maxLines: 4,
                borderRadius: 12.r,
              ),
              if (pickedPdf != null) ...[
                SizedBox(height: 10.h),
                PickedFileChip(
                  fileName: pickedPdf!.name,
                  onRemove: onRemovePdf,
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 16.h),
        ConsultationSectionCard(
          title: context.strings.laboratoryTests,
          titleTrailing: TextButton.icon(
            onPressed: onPickLabDocument,
            icon: Icon(Icons.upload_file, size: 16.sp, color: Colors.blue),
            label: Text(
              context.strings.uploadDocuments,
              style: TextStyle(fontSize: 12.sp, color: Colors.blue),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.withValues(alpha: 0.1),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: labTestsController,
                hintText: context.strings.requiredLabTests,
                maxLines: 3,
                borderRadius: 12.r,
              ),
              if (pickedLabDocument != null) ...[
                SizedBox(height: 10.h),
                PickedFileChip(
                  fileName: pickedLabDocument!.name,
                  onRemove: onRemoveLabDocument,
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 16.h),
        ConsultationSectionCard(
          title: context.strings.radiologyTests,
          titleTrailing: TextButton.icon(
            onPressed: onPickRadiologyDocument,
            icon: Icon(Icons.upload_file, size: 16.sp, color: Colors.blue),
            label: Text(
              context.strings.uploadDocuments,
              style: TextStyle(fontSize: 12.sp, color: Colors.blue),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.withValues(alpha: 0.1),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: radiologyTestsController,
                hintText: context.strings.requiredRadiologyTests,
                maxLines: 3,
                borderRadius: 12.r,
              ),
              if (pickedRadiologyDocument != null) ...[
                SizedBox(height: 10.h),
                PickedFileChip(
                  fileName: pickedRadiologyDocument!.name,
                  onRemove: onRemoveRadiologyDocument,
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 16.h),
        ConsultationSectionCard(
          title: context.strings.followUpDate,
          child: CustomTextField(
            controller: followUpDateController,
            readOnly: true,
            suffixIcon: followUpDateController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey, size: 18),
                    onPressed: onClearDate,
                  )
                : const Icon(Icons.calendar_today_outlined, color: Colors.grey),
            borderRadius: 12.r,
            onTap: onPickDate,
          ),
        ),
      ],
    );
  }
}
