import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class CustomRoleBasicInfoForm extends StatelessWidget {
  final String title;
  final String nameLabel;
  final String nameHint;

  const CustomRoleBasicInfoForm({
    super.key,
    required this.title,
    required this.nameLabel,
    required this.nameHint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.person_outline, color: theme.colorScheme.primary),
              SizedBox(width: 8.w),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Name Field
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) =>
                previous.fullName != current.fullName,
            builder: (context, state) {
              return CustomTextField(
                label: nameLabel,
                hintText: nameHint,
                isRequired: true,
                onChanged: (val) =>
                    context.read<AuthBloc>().add(FullNameChangedEvent(val)),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Email Address
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.emailAddress,
                hintText: context.strings.emailHint,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.mail_outline, color: Colors.grey),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) {
                  if (val != null &&
                      val.isNotEmpty &&
                      !Validators.isValidEmail(val.trim())) {
                    return context.strings.invalidEmail;
                  }
                  return null;
                },
                onChanged: (val) =>
                    context.read<AuthBloc>().add(EmailChangedEvent(val)),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Mobile Number
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.phone != current.phone,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.mobileNumber,
                hintText: context.strings.mobileHint,
                isRequired: true,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  color: Colors.grey,
                ),
                isPhoneField: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) {
                  if (val != null &&
                      val.isNotEmpty &&
                      !Validators.isValidPhone(val.trim())) {
                    return isArabic
                        ? 'يرجى إدخال رقم هاتف صحيح'
                        : 'Please enter a valid phone number';
                  }
                  return null;
                },
                onChanged: (val) =>
                    context.read<AuthBloc>().add(PhoneChangedEvent(val)),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Password
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) =>
                previous.password != current.password ||
                previous.isPasswordVisible != current.isPasswordVisible,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.password,
                hintText: context.strings.passwordHint,
                isRequired: true,
                obscureText: !state.isPasswordVisible,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) {
                  if (val != null && val.isNotEmpty && val.length < 6) {
                    return context.strings.invalidPassword;
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    state.isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () => context.read<AuthBloc>().add(
                    TogglePasswordVisibilityEvent(),
                  ),
                ),
                onChanged: (val) =>
                    context.read<AuthBloc>().add(PasswordChangedEvent(val)),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Confirm Password
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) =>
                previous.confirmPassword != current.confirmPassword ||
                previous.password != current.password ||
                previous.isConfirmPasswordVisible !=
                    current.isConfirmPasswordVisible,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.confirmPassword,
                hintText: context.strings.confirmPasswordHint,
                isRequired: true,
                obscureText: !state.isConfirmPasswordVisible,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) {
                  if (val != null && val.isNotEmpty && val != state.password) {
                    return context.strings.passwordsDoNotMatch;
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    state.isConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () => context.read<AuthBloc>().add(
                    ToggleConfirmPasswordVisibilityEvent(),
                  ),
                ),
                onChanged: (val) => context.read<AuthBloc>().add(
                  ConfirmPasswordChangedEvent(val),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
