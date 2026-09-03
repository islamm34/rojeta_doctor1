import 'package:flutter/material.dart';
import '../../../../../../auth/data/models/user_type_model.dart';
import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';
import 'add_service_text_field.dart';

class AddServiceForm extends StatefulWidget {
  final UserType userType;

  const AddServiceForm({super.key, required this.userType});

  @override
  State<AddServiceForm> createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddServiceForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _turnaroundTimeController = TextEditingController();
  final _preparationsController = TextEditingController();

  bool _isHomeCollection = false;

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _turnaroundTimeController.dispose();
    _preparationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRadiology = widget.userType == UserType.radiologyCenter;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddServiceTextField(
            controller: _nameController,
            label: isRadiology
                ? context.strings.scanName
                : context.strings.testName,
            icon: Icons.title,
          ),
          SizedBox(height: 16.h),
          AddServiceTextField(
            controller: _categoryController,
            label: context.strings.category,
            icon: Icons.category,
          ),
          SizedBox(height: 16.h),
          AddServiceTextField(
            controller: _priceController,
            label: context.strings.priceEgp,
            icon: Icons.attach_money,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.h),
          AddServiceTextField(
            controller: _turnaroundTimeController,
            label: context.strings.turnaroundTimeLabel,
            icon: Icons.timer,
          ),
          SizedBox(height: 16.h),
          AddServiceTextField(
            controller: _preparationsController,
            label: context.strings.preparationsOptional,
            icon: Icons.info_outline,
            maxLines: 3,
          ),
          SizedBox(height: 16.h),
          SwitchListTile(
            title: Text(context.strings.homeCollectionAvailable),
            value: _isHomeCollection,
            activeColor: context.colors.primary,
            onChanged: (val) => setState(() => _isHomeCollection = val),
            contentPadding: EdgeInsets.zero,
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.pop();
                }
              },
              child: Text(
                context.strings.saveService,
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
