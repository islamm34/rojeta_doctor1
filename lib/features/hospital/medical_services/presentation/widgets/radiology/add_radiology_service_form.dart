import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';

class AddRadiologyServiceForm extends StatefulWidget {
  const AddRadiologyServiceForm({super.key});

  @override
  State<AddRadiologyServiceForm> createState() =>
      _AddRadiologyServiceFormState();
}

class _AddRadiologyServiceFormState extends State<AddRadiologyServiceForm> {
  bool _contrastAgentRequired = false;

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
          CustomTextField(
            label: context.strings.serviceNameLabel,
            hintText: context.strings.serviceNameHint,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: context.strings.categoryLabel,
                  hintText: 'Diagnostic',
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CustomTextField(
                  label: context.strings.priceEgpLabel,
                  hintText: '250',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.strings.contrastAgentRequired,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        context.strings.requiresContrastDesc,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _contrastAgentRequired,
                  onChanged: (val) {
                    setState(() {
                      _contrastAgentRequired = val;
                    });
                  },
                  activeColor: AppColors.primary,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            label: context.strings.preparationInstructionsLabel,
            hintText: 'Fasting required 6 hours before...',
            maxLines: 3,
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 16.w, color: Colors.teal),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  context.strings.preparationInstructionsVisibleToPatient,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            label: context.strings.estimatedDurationLabel,
            hintText: 'e.g. 30 mins',
            suffixIcon: const Icon(Icons.access_time, color: Colors.grey),
          ),
          SizedBox(height: 24.h),
          CustomElevatedButton(
            text: context.strings.saveServiceBtn,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
