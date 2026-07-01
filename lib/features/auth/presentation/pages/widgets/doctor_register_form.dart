import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../shared/widgets/custom_textfield.dart';

class DoctorRegisterForm extends StatefulWidget {
  final Function(
    String name,
    String email,
    String phone,
    String password,
    String specialization,
    String syndicateNumber,
    String clinicAddress,
    String bio,
  ) onSubmit;
  final bool isLoading;

  const DoctorRegisterForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<DoctorRegisterForm> createState() => _DoctorRegisterFormState();
}

class _DoctorRegisterFormState extends State<DoctorRegisterForm> {
  int _currentStep = 0;
  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _specializationController = TextEditingController();
  final _syndicateController = TextEditingController();
  final _addressController = TextEditingController();
  final _bioController = TextEditingController();

  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _specializationController.dispose();
    _syndicateController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentStep == 0) {
      if (_step1FormKey.currentState?.validate() ?? false) {
        setState(() {
          _currentStep = 1;
        });
      }
    } else {
      if (_step2FormKey.currentState?.validate() ?? false) {
        widget.onSubmit(
          _nameController.text.trim(),
          _emailController.text.trim(),
          _phoneController.text.trim(),
          _passwordController.text.trim(),
          _specializationController.text.trim(),
          _syndicateController.text.trim(),
          _addressController.text.trim(),
          _bioController.text.trim(),
        );
      }
    }
  }

  void _previous() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Progress Indicator Bar
        Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 6.h,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
            12.hor,
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 6.h,
                decoration: BoxDecoration(
                  color: _currentStep >= 1 ? colors.primary : colors.outline.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
          ],
        ),
        24.ver,
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _currentStep == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Form(
            key: _step1FormKey,
            child: Column(
              children: [
                CustomTextField(
                  label: strings.fullName,
                  hintText: 'Dr. Jane Smith',
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
                  label: strings.email,
                  hintText: 'jane.smith@hospital.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return strings.fieldRequired;
                    }
                    if (!Validators.isValidEmail(val)) {
                      return strings.invalidEmail;
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
              ],
            ),
          ),
          secondChild: Form(
            key: _step2FormKey,
            child: Column(
              children: [
                CustomTextField(
                  label: strings.specialization,
                  hintText: 'Cardiology, Pediatrics, etc.',
                  controller: _specializationController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return strings.fieldRequired;
                    }
                    return null;
                  },
                ),
                20.ver,
                CustomTextField(
                  label: strings.syndicateNumber,
                  hintText: '12345678',
                  controller: _syndicateController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return strings.fieldRequired;
                    }
                    return null;
                  },
                ),
                20.ver,
                CustomTextField(
                  label: strings.clinicAddress,
                  hintText: 'Downtown medical building, Cairo',
                  controller: _addressController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return strings.fieldRequired;
                    }
                    return null;
                  },
                ),
                20.ver,
                CustomTextField(
                  label: strings.bio,
                  hintText: 'A brief description of your professional journey...',
                  controller: _bioController,
                  maxLines: 3,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return strings.fieldRequired;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        32.ver,
        Row(
          children: [
            if (_currentStep > 0) ...[
              Expanded(
                child: CustomElevatedButton(
                  text: 'Back',
                  onPressed: _previous,
                  backgroundColor: colors.surface,
                  foregroundColor: colors.primary,
                ),
              ),
              16.hor,
            ],
            Expanded(
              child: CustomElevatedButton(
                text: _currentStep == 0 ? 'Next' : strings.registerButton,
                isLoading: widget.isLoading,
                onPressed: _next,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
