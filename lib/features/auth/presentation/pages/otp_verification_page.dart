import 'package:flutter/material.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../../../../shared/widgets/custom_elevated_button.dart';
import 'user_type_selection_page.dart';
import 'widgets/otp_input_fields.dart';
import 'widgets/otp_timer.dart';

class OtpVerificationPage extends StatefulWidget {
  final UserType userType;

  const OtpVerificationPage({
    super.key,
    required this.userType,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  String _otpCode = '';
  bool _isLoading = false;

  void _verifyCode() {
    if (_otpCode.length == 4) {
      setState(() {
        _isLoading = true;
      });
      // Mock network latency then navigate to home
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          context.pushNamedAndRemoveUntil(AppRoutes.home);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final strings = context.strings;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colors.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              40.ver,
              Text(
                strings.otpVerificationTitle,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              12.ver,
              Text(
                strings.otpVerificationSubtitle,
                style: textTheme.bodyLarge?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              48.ver,
              OtpInputFields(
                onCompleted: (code) {
                  setState(() {
                    _otpCode = code;
                  });
                  _verifyCode();
                },
              ),
              30.ver,
              OtpTimer(
                onResend: () {
                  // Mock resending code
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('OTP code resent successfully!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              const Spacer(),
              CustomElevatedButton(
                text: strings.verifyButton,
                isLoading: _isLoading,
                onPressed: _verifyCode,
                backgroundColor: _otpCode.length < 4 ? colors.primary.withValues(alpha: 0.5) : colors.primary,
              ),
              20.ver,
            ],
          ),
        ),
      ),
    );
  }
}
