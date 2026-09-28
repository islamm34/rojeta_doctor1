import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';
import '../widgets/add_doctor/add_doctor_form.dart';
import '../widgets/add_doctor/doctor_info_notice.dart';
import '../widgets/add_doctor/doctor_photo_upload.dart';

class AddDoctorPage extends StatefulWidget {
  const AddDoctorPage({super.key});

  @override
  State<AddDoctorPage> createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  bool _isSuccess = false;

  void _handleSave() {
    setState(() {
      _isSuccess = true;
    });

    // We can simulate an API call or just show the success banner
    // context.pop() could be called later if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: AppBar(
        backgroundColor: AppColors.homeBg,
        surfaceTintColor: AppColors.homeBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.strings.addDoctorTitle,
          style: context.textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            if (_isSuccess) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 8.w),
                    Text(
                      context.strings.doctorAddedSuccessfully,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DoctorPhotoUpload(),
                  SizedBox(height: 24.h),
                  const AddDoctorForm(),
                  SizedBox(height: 24.h),
                  const DoctorInfoNotice(),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              text: context.strings.saveBtn,
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 20,
              ),
              onPressed: _handleSave,
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _isSuccess = false;
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                  backgroundColor: AppColors.primary.withValues(alpha: 0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                icon: const Icon(
                  Icons.person_add_alt_1_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
                label: Text(
                  context.strings.addAnotherDoctorBtn,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
