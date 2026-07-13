import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';

class AddIcuRoomForm extends StatefulWidget {
  const AddIcuRoomForm({super.key});

  @override
  State<AddIcuRoomForm> createState() => _AddIcuRoomFormState();
}

class _AddIcuRoomFormState extends State<AddIcuRoomForm> {
  final Map<String, bool> _equipment = {
    'Ventilator': true,
    'Infusion Pump': true,
    'Vitals Monitor': true,
    'Defibrillator': true,
  };

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
          Row(
            children: [
              Icon(
                Icons.meeting_room_outlined,
                color: AppColors.primary,
                size: 24.w,
              ),
              SizedBox(width: 8.w),
              Text(
                context.strings.addNewIcuRoomTitle,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          CustomTextField(
            label: context.strings.roomNumberLabel,
            hintText: context.strings.roomNumberHint,
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            label: context.strings.bedIdLabel,
            hintText: context.strings.bedIdHint,
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            label: context.strings.floorWingLabel,
            hintText: context.strings.selectLocationHint,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            context.strings.equipmentListLabel,
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildCheckbox(context.strings.ventilator, 'Ventilator'),
                    _buildCheckbox(
                      context.strings.infusionPump,
                      'Infusion Pump',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    _buildCheckbox(
                      context.strings.vitalsMonitor,
                      'Vitals Monitor',
                    ),
                    _buildCheckbox(
                      context.strings.defibrillator,
                      'Defibrillator',
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          CustomElevatedButton(
            text: context.strings.registerRoomBtn,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String title, String key) {
    return Row(
      children: [
        Checkbox(
          value: _equipment[key],
          onChanged: (val) {
            setState(() {
              _equipment[key] = val ?? false;
            });
          },
          activeColor: AppColors.primary,
        ),
        Expanded(
          child: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}
