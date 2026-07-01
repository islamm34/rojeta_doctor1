import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../../pages/user_type_selection_page.dart';

class LoginForm extends StatefulWidget {
  final UserType userType;
  final Function(String emailOrPhone, String password) onSubmit;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.userType,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        _emailOrPhoneController.text.trim(),
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
            label: widget.userType == UserType.doctor ? strings.email : strings.phone,
            hintText: widget.userType == UserType.doctor
                ? 'example@email.com'
                : '123 456 789',
            isPhoneField: widget.userType == UserType.patient,
            countryCode: '+20', // Default Egypt country code
            controller: _emailOrPhoneController,
            keyboardType: widget.userType == UserType.doctor
                ? TextInputType.emailAddress
                : TextInputType.phone,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return strings.fieldRequired;
              }
              if (widget.userType == UserType.doctor && !Validators.isValidEmail(val)) {
                return strings.invalidEmail;
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
            text: strings.loginButton,
            isLoading: widget.isLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
