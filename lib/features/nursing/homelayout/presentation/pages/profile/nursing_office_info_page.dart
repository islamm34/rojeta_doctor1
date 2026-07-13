import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_event.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_state.dart';

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
      verificationStatus: context.read<NursingBloc>().state.officeInfo?.verificationStatus ?? 'ACTIVE STATUS',
    );
    context.read<NursingBloc>().add(UpdateNursingOfficeInfoEvent(updatedInfo));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Office Information',
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
          if (state.officeInfo == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final info = state.officeInfo!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage your office\'s public profile and administrative contact details.',
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
                          Icon(Icons.edit_note_outlined, color: const Color(0xFF0F2D52), size: 20.w),
                          SizedBox(width: 8.w),
                          Text(
                            'General Details',
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildTextFieldLabel('Office Name'),
                      _buildTextField(controller: _nameController),
                      SizedBox(height: 12.h),
                      _buildTextFieldLabel('LICENSE NUMBER'),
                      _buildTextField(controller: _licenseController),
                      SizedBox(height: 12.h),
                      _buildTextFieldLabel('PRIMARY CONTACT EMAIL'),
                      _buildTextField(controller: _emailController),
                      SizedBox(height: 12.h),
                      _buildTextFieldLabel('PHONE NUMBER'),
                      _buildTextField(controller: _phoneController),
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
                          Icon(Icons.description_outlined, color: const Color(0xFF0F2D52), size: 20.w),
                          SizedBox(width: 8.w),
                          Text(
                            'About the Center',
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildTextFieldLabel('LABORATORY DESCRIPTION'),
                      _buildTextField(
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
                        child: Icon(Icons.verified_outlined, color: const Color(0xFF0284C7), size: 24.w),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Verification Status',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF0F2D52),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Your Center is currently verified for the 2026 calendar year.',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF0F2D52),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6EE7B7), // Mint
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          info.verificationStatus,
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
                Icon(Icons.info_outline, color: const Color(0xFF64748B), size: 16.w),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Unsaved changes will be lost if you leave this page.',
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
                      'DISCARD',
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
                    icon: Icon(Icons.save_outlined, color: Colors.white, size: 16.w),
                    label: Text(
                      'SAVE CHANGES',
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

  Widget _buildTextFieldLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: const Color(0xFF475569),
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Color(0xFF0F172A)),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
        ),
      ),
    );
  }
}
