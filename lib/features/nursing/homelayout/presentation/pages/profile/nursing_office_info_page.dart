import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../bloc/nursing_bloc.dart';
import '../../bloc/nursing_event.dart';
import '../../bloc/nursing_state.dart';
import 'widgets/nursing_field_label.dart';
import 'widgets/nursing_text_field.dart';

class NursingOfficeInfoPage extends StatefulWidget {
  const NursingOfficeInfoPage({super.key});

  @override
  State<NursingOfficeInfoPage> createState() => _NursingOfficeInfoPageState();
}

class _NursingOfficeInfoPageState extends State<NursingOfficeInfoPage> {
  late TextEditingController _nameController;
  late TextEditingController _licenseController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    final state = context.read<NursingBloc>().state;
    final info = state.officeInfo;

    _nameController = TextEditingController(text: info?.officeName ?? '');
    _licenseController = TextEditingController(text: info?.licenseNumber ?? '');
    _emailController = TextEditingController(text: info?.email ?? '');
    _phoneController = TextEditingController(text: info?.phone ?? '');
    _descController = TextEditingController(text: info?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _licenseController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedInfo = NursingOfficeInfoModel(
      officeName: _nameController.text.trim(),
      licenseNumber: _licenseController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      description: _descController.text.trim(),
      verificationStatus:
          context.read<NursingBloc>().state.officeInfo?.verificationStatus ??
          'ACTIVE STATUS',
    );
    context.read<NursingBloc>().add(UpdateNursingOfficeInfoEvent(updatedInfo));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          strings.officeInformation,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          if (state.officeInfo == null &&
              state.status == NursingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final info = state.officeInfo ?? const NursingOfficeInfoModel();

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.manageOfficeSubtitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF475569),
                  ),
                ),
                SizedBox(height: 16.h),

                // General Details
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.edit_note_outlined,
                            color: const Color(0xFF0F2D52),
                            size: 20.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            strings.generalDetails,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      NursingFieldLabel(text: strings.officeName),
                      NursingTextField(controller: _nameController),
                      SizedBox(height: 12.h),
                      NursingFieldLabel(text: strings.licenseNumber),
                      NursingTextField(controller: _licenseController),
                      SizedBox(height: 12.h),
                      NursingFieldLabel(text: strings.primaryContactEmail),
                      NursingTextField(controller: _emailController),
                      SizedBox(height: 12.h),
                      NursingFieldLabel(text: strings.phoneNumber),
                      NursingTextField(controller: _phoneController),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // About the Center
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: const Color(0xFF0F2D52),
                            size: 20.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            strings.aboutTheCenter,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      NursingFieldLabel(text: strings.officeDescription),
                      NursingTextField(
                        controller: _descController,
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Verification Status
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE), // Light blue
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFBAE6FD)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: const BoxDecoration(
                          color: Color(0xFFBAE6FD),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_outlined,
                          color: const Color(0xFF0284C7),
                          size: 24.w,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        strings.verificationStatus,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF0F2D52),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        strings.verifiedStatusDesc,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF0F2D52),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6EE7B7), // Mint
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          info.verificationStatus ?? 'ACTIVE STATUS',
                          style: TextStyle(
                            color: const Color(0xFF064E3B),
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100.h), // space for bottom buttons
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        color: const Color(0xFFF8FAFC),
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF64748B),
                  size: 16.w,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    strings.unsavedChangesWarning,
                    style: TextStyle(
                      color: const Color(0xFF64748B),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      side: const BorderSide(color: Color(0xFF94A3B8)),
                    ),
                    child: Text(
                      strings.discard.toUpperCase(),
                      style: TextStyle(
                        color: const Color(0xFF0F2D52),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _saveChanges,
                    icon: Icon(
                      Icons.save_outlined,
                      color: Colors.white,
                      size: 16.w,
                    ),
                    label: Text(
                      strings.saveChanges.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
