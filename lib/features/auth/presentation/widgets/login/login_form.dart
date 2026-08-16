import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes/app_router.dart';
import '../../../../../core/local/user_hive_helper.dart';
import '../../../../../core/utils/role_navigation_helper.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateBasedOnRole(BuildContext context) {
    RoleNavigationHelper.navigateToRoleDashboard(context, clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Phone Number Field
            CustomTextField(
              label: context.strings.phone,
              hintText: context.strings.phoneHint,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: theme.colorScheme.primary,
                size: 20.w,
              ),
              borderRadius: 12.r,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.strings.fieldRequired;
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // Password Field
            CustomTextField(
              label: context.strings.password,
              hintText: context.strings.enterYourPasswordHint,
              controller: _passwordController,
              obscureText: _obscurePassword,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: theme.colorScheme.primary,
                size: 20.w,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey.shade500,
                  size: 20.w,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              borderRadius: 12.r,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.strings.fieldRequired;
                }
                if (value.length < 6) {
                  return context.strings.invalidPassword;
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),

            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.forgotPassword);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  context.strings.forgotPassword,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Sign In Button with BlocConsumer
            BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == AuthStatus.loaded) {
                  _navigateBasedOnRole(context);
                } else if (state.status == AuthStatus.error) {
                  if (state.message != null && state.message!.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message!),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              builder: (context, state) {
                final isLoading = state.status == AuthStatus.loading;

                if (isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return CustomElevatedButton(
                  text: context.strings.signIn,
                  icon: Icon(Icons.login, color: Colors.white, size: 20.w),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            LoginSubmittedEvent(
                              phone: _phoneController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                    }
                  },
                );
              },
            ),
            SizedBox(height: 20.h),

            // OR Divider
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.grey.shade300, thickness: 1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'OR',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.grey.shade300, thickness: 1),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Don't have an account? Create Account
            Center(
              child: RichText(
                text: TextSpan(
                  text: '${context.strings.dontHaveAccount} ',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
                  ),
                  children: [
                    TextSpan(
                      text: context.strings.createAccount,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pushNamed(AppRoutes.userTypeSelection);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
