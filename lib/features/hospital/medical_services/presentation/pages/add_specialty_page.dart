import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';
import '../bloc/medical_services_bloc.dart';
import '../bloc/medical_services_event.dart';

class AddSpecialtyPage extends StatefulWidget {
  const AddSpecialtyPage({super.key});

  @override
  State<AddSpecialtyPage> createState() => _AddSpecialtyPageState();
}

class _AddSpecialtyPageState extends State<AddSpecialtyPage> {
  String? selectedSpecialty;
  final TextEditingController descriptionController = TextEditingController();
  bool emergencyAvailable = false;

  final List<String> availableSpecialties = [
    'Pediatrics',
    'Cardiology',
    'Orthopedic Clinic',
    'Neurology',
    'Ophthalmology',
    'Dentistry',
    'Dermatology',
  ];

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void _saveSpecialty() {
    if (selectedSpecialty != null) {
      context.read<MedicalServicesBloc>().add(
        AddSpecialtyEvent(
          name: selectedSpecialty!,
          description: descriptionController.text,
          hasEmergency: emergencyAvailable,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: AppBar(
        backgroundColor: AppColors.homeBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.strings.addSpecialtyTitle,
          style: context.textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFormCard(context),
            SizedBox(height: 24.h),
            _buildInfoBox(context),
            const Spacer(),
            CustomElevatedButton(
              onPressed: selectedSpecialty != null ? _saveSpecialty : () {},
              text: context.strings.saveAndAddDoctors,
              backgroundColor: selectedSpecialty != null
                  ? AppColors.primary
                  : Colors.grey[400]!,
            ),
            SizedBox(height: 12.h),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: Text(
                context.strings.addAnotherSpecialty,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          Text(
            context.strings.specialtyDetailsTitle,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            context.strings.specialtyNameLabel,
            style: context.textTheme.labelMedium?.copyWith(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          DropdownButtonFormField<String>(
            initialValue: selectedSpecialty,
            hint: const Text('Select a specialty'),
            items: availableSpecialties.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedSpecialty = newValue;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            context.strings.shortDescriptionLabel,
            style: context.textTheme.labelMedium?.copyWith(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: context.strings.shortDescriptionHint,
              hintStyle: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey[400],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.strings.emergencyServicesAvailable,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.strings.emergencyServicesDesc,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: emergencyAvailable,
                onChanged: (val) {
                  setState(() {
                    emergencyAvailable = val;
                  });
                },
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.blue[700], size: 24.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              context.strings.addSpecialtyInfoBox,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
