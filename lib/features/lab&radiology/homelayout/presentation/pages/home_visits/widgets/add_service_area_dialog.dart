import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/shared/widgets/custom_elevated_button.dart';
import 'package:rojeta_doctor/shared/widgets/custom_textfield.dart';

import '../../../../data/models/home_visit_config_model.dart';

class AddServiceAreaDialog extends StatefulWidget {
  const AddServiceAreaDialog({super.key});

  @override
  State<AddServiceAreaDialog> createState() => _AddServiceAreaDialogState();
}

class _AddServiceAreaDialogState extends State<AddServiceAreaDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _radiusController;
  late final TextEditingController _techsController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _radiusController = TextEditingController(text: '15');
    _techsController = TextEditingController(text: '2');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _radiusController.dispose();
    _techsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final radius = int.tryParse(_radiusController.text.trim()) ?? 10;
      final techs = int.tryParse(_techsController.text.trim()) ?? 1;

      final newArea = ServiceAreaModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        radiusKm: radius,
        techsAvailable: techs,
      );

      Navigator.of(context).pop(newArea);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.strings.addArea,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2D52),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: context.strings.location,
                hintText: 'e.g. Downtown / Nasr City',
                controller: _nameController,
                isRequired: true,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return context.strings.somethingWentWrong;
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: context.strings.serviceAreaRadius,
                hintText: '15',
                controller: _radiusController,
                keyboardType: TextInputType.number,
                isRequired: true,
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: 'Available Techs / Staff',
                hintText: '2',
                controller: _techsController,
                keyboardType: TextInputType.number,
                isRequired: true,
              ),
              SizedBox(height: 24.h),
              CustomElevatedButton(
                text: context.strings.confirmButton,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
