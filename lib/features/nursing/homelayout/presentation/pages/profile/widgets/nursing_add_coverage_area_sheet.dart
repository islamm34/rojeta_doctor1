import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';

import 'nursing_field_label.dart';
import 'nursing_text_field.dart';

class NursingAddCoverageAreaSheet extends StatefulWidget {
  final ValueChanged<NursingCoverageAreaModel> onAdd;

  const NursingAddCoverageAreaSheet({super.key, required this.onAdd});

  @override
  State<NursingAddCoverageAreaSheet> createState() =>
      _NursingAddCoverageAreaSheetState();
}

class _NursingAddCoverageAreaSheetState
    extends State<NursingAddCoverageAreaSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController(
    text: '10',
  );
  final TextEditingController _feeController = TextEditingController(text: '0');
  bool _isActive = true;

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _radiusController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final area = NursingCoverageAreaModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      city: _cityController.text.trim(),
      radiusKm: int.tryParse(_radiusController.text.trim()) ?? 10,
      extraFee: double.tryParse(_feeController.text.trim()) ?? 0.0,
      isActive: _isActive,
    );

    widget.onAdd(area);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                strings.addArea,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2D52),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF64748B)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          NursingFieldLabel(text: strings.branchName),
          NursingTextField(
            controller: _nameController,
            hintText: 'e.g., Nasr City, New Cairo, Mohandessin',
          ),
          SizedBox(height: 12.h),
          NursingFieldLabel(text: strings.branchAddress),
          NursingTextField(
            controller: _cityController,
            hintText: 'e.g., Cairo, Giza, Alexandria',
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NursingFieldLabel(text: 'RADIUS (KM)'),
                    NursingTextField(
                      controller: _radiusController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NursingFieldLabel(
                      text: strings.collectionFee.toUpperCase(),
                    ),
                    NursingTextField(
                      controller: _feeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                strings.serviceStatus,
                style: TextStyle(
                  color: const Color(0xFF0F172A),
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
              const Spacer(),
              Switch.adaptive(
                value: _isActive,
                onChanged: (val) => setState(() => _isActive = val),
                activeThumbColor: const Color(0xFF2563EB),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                strings.addArea,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
