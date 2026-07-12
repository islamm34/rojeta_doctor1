import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../widgets/registration_success/registration_status_header.dart';
import '../widgets/registration_success/request_summary_card.dart';
import '../widgets/registration_success/whats_next_card.dart';
import '../widgets/registration_success/request_number_section.dart';
import '../widgets/registration_success/contact_us_section.dart';
import '../../../../config/routes/app_router.dart';

class RegistrationSuccessPage extends StatelessWidget {
  const RegistrationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const RegistrationStatusHeader(),
                    SizedBox(height: 32.h),
                    const RequestSummaryCard(),
                    SizedBox(height: 24.h),
                    const WhatsNextCard(),
                    SizedBox(height: 32.h),
                    const RequestNumberSection(),
                    SizedBox(height: 32.h),
                    const ContactUsSection(),
                    SizedBox(height: 32.h),
                    OutlinedButton.icon(
                      onPressed: () {
                        context.pushNamedAndRemoveUntil(
                          AppRoutes.login,
                          predicate: (route) => false,
                        );
                      },
                      icon: const Icon(Icons.home_outlined),
                      label: Text(context.strings.returnToLoginPage),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF10B981),
                        side: const BorderSide(color: Color(0xFF10B981)),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        textStyle: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Column(
                      children: [
                        Text(
                          '🙏 ${context.strings.thankYouForJoining}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          context.strings.lookForwardToWorkingWithYou,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(
                              0xFF10B981,
                            ).withValues(alpha: 0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
