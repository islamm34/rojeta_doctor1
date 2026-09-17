import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';

class AddServiceHeaderCard extends StatelessWidget {
  final UserType userType;
  final bool isEdit;

  const AddServiceHeaderCard({
    super.key,
    required this.userType,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    final isRadiology = userType == UserType.radiologyCenter;
    final title = isEdit
        ? '${context.strings.edit} ${isRadiology ? context.strings.scans : context.strings.testName}'
        : (isRadiology
              ? context.strings.addNewScan
              : context.strings.addNewTest);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isEdit
                ? Icons.edit_note
                : (isRadiology ? Icons.radar : Icons.science),
            color: Colors.white,
            size: 40.w,
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: context.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
