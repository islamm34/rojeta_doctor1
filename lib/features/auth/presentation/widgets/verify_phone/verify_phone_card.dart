import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:rojeta_doctor/core/utils/flutter_secure_storage_helper.dart';
import 'package:rojeta_doctor/core/utils/role_navigation_helper.dart';
import '../../../../../config/routes/app_router.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../core/local/user_hive_helper.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class VerifyPhoneCard extends StatefulWidget {
  final String? comefrom;
  final String? phone;
  const VerifyPhoneCard({super.key, this.comefrom, this.phone});

  @override
  State<VerifyPhoneCard> createState() => _VerifyPhoneCardState();
}

class _VerifyPhoneCardState extends State<VerifyPhoneCard> {
  late final TextEditingController _pinController;

  String get _effectivePhone {
    if (widget.phone != null && widget.phone!.trim().isNotEmpty) {
      return widget.phone!.trim();
    }
    final state = context.read<AuthBloc>().state;
    if (state.phone.trim().isNotEmpty) return state.phone.trim();
    if (state.organizationNumber.trim().isNotEmpty) {
      return state.organizationNumber.trim();
    }
    final savedUser = UserHiveHelper.getUser();
    if (savedUser?.phone != null && savedUser!.phone!.trim().isNotEmpty) {
      return savedUser.phone!.trim();
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    final currentOtp = context.read<AuthBloc>().state.otpCode;
    _pinController = TextEditingController(text: currentOtp);
    _pinController.addListener(_onPinChanged);

    final initialPhone = _effectivePhone;
    if (initialPhone.isNotEmpty &&
        context.read<AuthBloc>().state.phone.isEmpty) {
      context.read<AuthBloc>().add(PhoneChangedEvent(initialPhone));
    }
  }

  void _onPinChanged() {
    setState(() {});
    final authBloc = context.read<AuthBloc>();
    if (!authBloc.isClosed && authBloc.state.otpCode != _pinController.text) {
      authBloc.add(OtpChangedEvent(_pinController.text));
    }
  }

  @override
  void dispose() {
    _pinController.removeListener(_onPinChanged);
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _navigateBasedOnRole(
    BuildContext context,
    AuthState state,
  ) async {
    final token = (state.token != null && state.token!.trim().isNotEmpty)
        ? state.token
        : (await FlutterSecureStorageHelper.getToken());

    if (!context.mounted) return;

    if (token == null || token.trim().isEmpty) {
      context.pushNamedAndRemoveUntil(
        AppRoutes.login,
        predicate: (route) => false,
      );
      return;
    }

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
              final phone = _effectivePhone;
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
            controller: _pinController,
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            onChanged: (value) {
              final authBloc = context.read<AuthBloc>();
              if (!authBloc.isClosed) {
                authBloc.add(OtpChangedEvent(value));
              }
            },
            onCompleted: (pin) {
              final authBloc = context.read<AuthBloc>();
              if (!authBloc.isClosed) {
                authBloc.add(OtpChangedEvent(pin));
              }
            },
            onSubmitted: (pin) {
              final authBloc = context.read<AuthBloc>();
              if (!authBloc.isClosed && pin.trim().length == 6) {
                authBloc.add(OtpChangedEvent(pin.trim()));
                authBloc.add(VerifyOtpSubmittedEvent(_effectivePhone));
              }
            },
          ),
          SizedBox(height: 32.h),
          BlocConsumer<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.status != current.status ||
                previous.message != current.message,
            listener: (context, state) {
              if (state.status == AuthStatus.loaded) {
                if (widget.comefrom == 'forgotPassword') {
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
              final pin = _pinController.text.trim();
              final isOtpValid =
                  pin.length == 6 || state.otpCode.trim().length == 6;
              final isValid = isOtpValid && !isLoading;

              return Column(
                children: [
                  CustomElevatedButton(
                    text: context.strings.verifyAndCompleteRegistration,
                    isLoading: isLoading,
                    onPressed: isValid
                        ? () {
                            final authBloc = context.read<AuthBloc>();
                            if (!authBloc.isClosed) {
                              final finalOtp = pin.isNotEmpty
                                  ? pin
                                  : state.otpCode.trim();
                              authBloc.add(OtpChangedEvent(finalOtp));
                              authBloc.add(
                                VerifyOtpSubmittedEvent(_effectivePhone),
                              );
                            }
                          }
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            final authBloc = context.read<AuthBloc>();
                            if (!authBloc.isClosed) {
                              authBloc.add(
                                ResendOtpSubmittedEvent(_effectivePhone),
                              );
                            }
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
