import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:rojeta_doctor/core/local/user_hive_helper.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';
import 'package:rojeta_doctor/core/utils/role_navigation_helper.dart';
import '../../../../../config/routes/app_router.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class VerifyPhoneCard extends StatelessWidget {
  final String? comefrom;
  const VerifyPhoneCard({super.key, this.comefrom});

  void _navigateBasedOnRole(BuildContext context, AuthState state) {
    RoleNavigationHelper.navigateToRoleDashboard(
      context,
      fallbackType: state.selectedType,
      clearStack: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: context.theme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.theme.colorScheme.outline.withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.theme.colorScheme.primary),
      borderRadius: BorderRadius.circular(8.r),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.phone_in_talk_outlined,
              color: context.theme.colorScheme.primary,
              size: 32.sp,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            context.strings.verifyYourPhone,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) =>
                previous.phone != current.phone ||
                previous.organizationNumber != current.organizationNumber,
            builder: (context, state) {
              final phone = state.phone.isNotEmpty
                  ? state.phone
                  : (state.organizationNumber.isNotEmpty
                      ? state.organizationNumber
                      : '');
              return Column(
                children: [
                  Text(
                    context.strings.weSentVerificationCodeTo,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    phone,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 32.h),
          Text(
            context.strings.enterOtpCode,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 16.h),
          Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            onChanged: (value) {
              context.read<AuthBloc>().add(OtpChangedEvent(value));
            },
          ),
          SizedBox(height: 32.h),
          BlocConsumer<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.status != current.status ||
                previous.message != current.message,
            listener: (context, state) {
              if (state.status == AuthStatus.loaded) {
                if (comefrom == 'forgotPassword') {
                  context.pushNamedAndRemoveUntil(
                    AppRoutes.resetPassword,
                    predicate: (route) => false,
                  );
                } else {
                  _navigateBasedOnRole(context, state);
                }
              } else if (state.status == AuthStatus.error) {
                if (state.message.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } else if (state.status == AuthStatus.initial &&
                  state.message.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state.status == AuthStatus.loading;
              final isValid = state.otpCode.length == 6 && !isLoading;

              return Column(
                children: [
                  CustomElevatedButton(
                    text: context.strings.verifyAndCompleteRegistration,
                    isLoading: isLoading,
                    onPressed: isValid
                        ? () {
                            context.read<AuthBloc>().add(
                                  const VerifyOtpSubmittedEvent(),
                                );
                          }
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                                  const ResendOtpSubmittedEvent(),
                                );
                          },
                    child: Text(
                      context.strings.resendCode,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: isLoading
                            ? Colors.grey
                            : context.theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
