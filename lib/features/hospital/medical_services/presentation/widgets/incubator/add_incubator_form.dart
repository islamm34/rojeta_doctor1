import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';

class AddIncubatorForm extends StatefulWidget {
  const AddIncubatorForm({super.key});

  @override
  State<AddIncubatorForm> createState() => _AddIncubatorFormState();
}

class _AddIncubatorFormState extends State<AddIncubatorForm> {
  final Map<String, bool> _monitoring = {'Vitals': true, 'Environment': true};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.strings.addNewIncubatorTitle,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            label: context.strings.unitIdLabel,
            hintText: context.strings.unitIdHint,
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            label: context.strings.modelLabel,
            hintText: 'Steri-Therm v4',
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            label: context.strings.wingSectionLabel,
            hintText: 'e.g. West Wing B',
          ),
          SizedBox(height: 24.h),
          Text(
            context.strings.monitoringTypeLabel,
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _buildCheckbox(context.strings.vitals, 'Vitals')),
              Expanded(
                child: _buildCheckbox(
                  context.strings.environment,
                  'Environment',
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          CustomElevatedButton(
            text: context.strings.registerUnitBtn,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String title, String key) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: _monitoring[key],
            onChanged: (val) {
              setState(() {
                _monitoring[key] = val ?? false;
              });
            },
            activeColor: AppColors.primary,
          ),
          Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[800],
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
