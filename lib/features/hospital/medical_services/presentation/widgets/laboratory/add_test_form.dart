import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';

class AddTestForm extends StatefulWidget {
  const AddTestForm({super.key});

  @override
  State<AddTestForm> createState() => _AddTestFormState();
}

class _AddTestFormState extends State<AddTestForm> {
  bool _homeCollectionAvailable = true;

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
            label: context.strings.testNameLabel,
            hintText: context.strings.testNameHint,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: context.strings.categoryLabel,
                  hintText: 'Hematology',
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
                  hintText: '0.00',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.strings.homeCollectionAvailable,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.strings.technicianVisitAddress,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _homeCollectionAvailable,
                onChanged: (val) {
                  setState(() {
                    _homeCollectionAvailable = val;
                  });
                },
                activeColor: Colors.amber,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            label: context.strings.preparationInstructionsOptional,
            hintText: 'e.g. 8-12 hours fasting required',
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
            label: context.strings.estimatedResultTimeLabel,
            hintText: '24 Hours',
          ),
          SizedBox(height: 24.h),
          CustomElevatedButton(
            text: context.strings.saveTestBtn,
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
