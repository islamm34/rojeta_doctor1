import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/registeraion_steps_app_bar.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/registeration_steps_indicator.dart';
import '../../../../../config/routes/app_router.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../core/di/injector.dart';
import '../../bloc/auth_bloc.dart';
import '../../../../../core/utils/snackbar_helper.dart';
import '../../../../../core/utils/validators.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import '../../widgets/basic_information/basic_info_form.dart';

class BasicInformationPage extends StatelessWidget {
  final bool isFinalStep;

  const BasicInformationPage({super.key, this.isFinalStep = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: injector<AuthBloc>(),
      child: _BasicInformationView(isFinalStep: isFinalStep),
    );
  }
}

class _BasicInformationView extends StatelessWidget {
  final bool isFinalStep;

  const _BasicInformationView({this.isFinalStep = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      appBar: RegisteraionStepsAppBar(stepText: context.strings.step2Of5),
      body: SafeArea(
        child: Column(
          children: [
            RegisterationStepsIndicator(progress: 0.4),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    const BasicInfoForm(),

                    SizedBox(height: 32.h),

                    // Buttons Row
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            text: context.strings.back,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            textStyle: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: Colors.black87,
                            ),
                            onPressed: () {
                              if (context.canPop) {
                                context.pop();
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: BlocConsumer<AuthBloc, AuthState>(
                            listenWhen: (previous, current) =>
                                previous.checkPhoneStatus !=
                                    current.checkPhoneStatus ||
                                previous.isPhoneExists != current.isPhoneExists,
                            listener: (context, state) {
                              if (state.checkPhoneStatus == AuthStatus.loaded &&
                                  state.isPhoneExists != null) {
                                if (state.isPhoneExists == true) {
                                  SnackbarHelper.showError(
                                    context,
                                    message: state.message.isNotEmpty
                                        ? state.message
                                        : context
                                              .strings
                                              .phoneNumberAlreadyRegistered,
                                  );
                                } else {
                                  SnackbarHelper.showSuccess(
                                    context,
                                    message: state.message.isNotEmpty
                                        ? state.message
                                        : context.strings.phoneNumberAvailable,
                                  );
                                  context.pushNamed(
                                    AppRoutes.professionalInformation,
                                  );
                                }
                              } else if (state.checkPhoneStatus ==
                                  AuthStatus.error) {
                                SnackbarHelper.showError(
                                  context,
                                  message: state.message,
                                );
                              }
                            },
                            builder: (context, state) {
                              final isLoading =
                                  state.checkPhoneStatus == AuthStatus.loading;
                              final isValid =
                                  state.isBasicInfoFormValid && !isLoading;
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  gradient: isValid
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF005BEA),
                                            Color(0xFF00C6FB),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        )
                                      : null,
                                  color: isValid ? null : Colors.grey.shade300,
                                ),
                                child: isLoading
                                    ? SizedBox(
                                        height: 48.h,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : CustomElevatedButton(
                                        text: isFinalStep
                                            ? context
                                                  .strings
                                                  .completeRegistration
                                            : context.strings.next,
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: isValid
                                            ? Colors.white
                                            : Colors.grey.shade500,
                                        onPressed: () {
                                          if (isValid) {
                                            context.read<AuthBloc>().add(
                                                  const CheckPhoneSubmittedEvent(),
                                                );
                                          } else {
                                            if (state.fullName.trim().isEmpty) {
                                              SnackbarHelper.showError(
                                                context,
                                                message: context.strings.fullNameHint,
                                              );
                                            } else if (!Validators.isValidEmail(state.email.trim())) {
                                              SnackbarHelper.showError(
                                                context,
                                                message: context.strings.invalidEmail,
                                              );
                                            } else if (!Validators.isValidPhone(state.phone.trim())) {
                                              SnackbarHelper.showError(
                                                context,
                                                message: context.strings.phoneHint,
                                              );
                                            } else if (!Validators.isValidPassword(state.password, minLength: 6)) {
                                              SnackbarHelper.showError(
                                                context,
                                                message: context.strings.invalidPassword,
                                              );
                                            } else if (state.confirmPassword != state.password) {
                                              SnackbarHelper.showError(
                                                context,
                                                message: context.strings.passwordsDoNotMatch,
                                              );
                                            }
                                          }
                                        },
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Footer Login
                    RichText(
                      text: TextSpan(
                        text: '${context.strings.alreadyHaveAccount} ',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 14.sp,
                        ),
                        children: [
                          TextSpan(
                            text: context.strings.loginHere,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushReplacementNamed(AppRoutes.login);
                              },
                          ),
                        ],
                      ),
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
