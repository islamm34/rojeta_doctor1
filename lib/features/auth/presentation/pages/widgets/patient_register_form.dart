import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../shared/widgets/custom_textfield.dart';

class PatientRegisterForm extends StatefulWidget {
  final Function(String name, String phone, String password) onSubmit;
  final bool isLoading;

  const PatientRegisterForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<PatientRegisterForm> createState() => _PatientRegisterFormState();
}

class _PatientRegisterFormState extends State<PatientRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        _nameController.text.trim(),
        _phoneController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final colors = context.colors;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: strings.fullName,
            hintText: 'John Doe',
            controller: _nameController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return strings.fieldRequired;
              }
              return null;
            },
          ),
          20.ver,
          CustomTextField(
            label: strings.phone,
            hintText: '123 456 789',
            isPhoneField: true,
            countryCode: '+20',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return strings.fieldRequired;
              }
              return null;
            },
          ),
          20.ver,
          CustomTextField(
            label: strings.password,
            hintText: '••••••••',
            controller: _passwordController,
            obscureText: _isPasswordObscured,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
              onPressed: () {
                setState(() {
                  _isPasswordObscured = !_isPasswordObscured;
                });
              },
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return strings.fieldRequired;
              }
              if (val.length < 6) {
                return strings.invalidPassword;
              }
              return null;
            },
          ),
          32.ver,
          CustomElevatedButton(
            text: strings.registerButton,
            isLoading: widget.isLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
