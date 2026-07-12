import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/file_picker_helper.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
  
class ConsultationFormSection extends StatefulWidget {
  const ConsultationFormSection({super.key});

  @override
  State<ConsultationFormSection> createState() =>
      _ConsultationFormSectionState();
}

class _ConsultationFormSectionState extends State<ConsultationFormSection> {
  PlatformFile? _pickedPdf;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSectionCard(
          context,
          icon: Icons.description_outlined,
          title: context.strings.diagnosis,
          child: CustomTextField(
            hintText: context.strings.enterDiagnosis,
            maxLines: 4,
            borderRadius: 12.r,
          ),
        ),
        SizedBox(height: 16.h),
        _buildSectionCard(
          context,
          title: context.strings.medicalNotes,
          child: Row(
            children: [
              Expanded(
                child: _buildImageNoteBox(
                  context,
                  context.strings.prescriptionImgHere,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildImageNoteBox(
                  context,
                  context.strings.prescriptionImgHere,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildSectionCard(
          context,
          title: context.strings.prescription,
          titleTrailing: TextButton.icon(
            onPressed: _pickPdf,
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
                hintText: context.strings.medicationDetails,
                maxLines: 4,
                borderRadius: 12.r,
              ),
              if (_pickedPdf != null) ...[
                SizedBox(height: 10.h),
                _PickedFileChip(
                  fileName: _pickedPdf!.name,
                  onRemove: _removePdf,
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildSectionCard(
          context,
          title: context.strings.laboratoryTests,
          child: CustomTextField(
            hintText: context.strings.requiredLabTests,
            maxLines: 3,
            borderRadius: 12.r,
          ),
        ),
        SizedBox(height: 16.h),
        _buildSectionCard(
          context,
          title: context.strings.radiologyTests,
          child: CustomTextField(
            hintText: context.strings.requiredRadiologyTests,
            maxLines: 3,
            borderRadius: 12.r,
          ),
        ),
        SizedBox(height: 16.h),
        _buildSectionCard(
          context,
          title: context.strings.followUpDate,
          child: CustomTextField(
            readOnly: true,
            suffixIcon: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
            ),
            borderRadius: 12.r,
            onTap: () {
              // Show date picker
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    IconData? icon,
    required String title,
    Widget? titleTrailing,
    required Widget child,
  }) {
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(icon, size: 16.sp, color: Colors.blue),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              if (titleTrailing != null) titleTrailing,
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildImageNoteBox(BuildContext context, String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 12.sp),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h),
              ),
              child: Text(
                context.strings.openBtn,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PickedFileChip extends StatelessWidget {
  final String fileName;
  final VoidCallback onRemove;

  const _PickedFileChip({required this.fileName, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf, size: 18.sp, color: Colors.red.shade600),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              fileName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 18.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
