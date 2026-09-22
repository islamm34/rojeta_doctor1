import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes/app_router.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/local/user_hive_helper.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../auth/presentation/bloc/auth_event.dart';
import '../../../../doctor/profile/presentation/widgets/settings/settings_contact_support_sheet.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../widgets/settings_action_tile.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_switch_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<SettingsBloc>()..add(LoadSettingsEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7FAFD),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text(
            context.strings.settings,
            style: context.textTheme.titleMedium?.copyWith(
              color: const Color(0xFF0F2D52),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state.status == SettingsStatus.failure &&
                state.errorMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            if (state.status == SettingsStatus.loading &&
                state.settings == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final currentLanguage = state.settings?.languageCode ?? 'en';
            final newBookings = state.settings?.newBookingsEnabled ?? true;
            final appointmentReminders =
                state.settings?.appointmentRemindersEnabled ?? true;
            final emergencyRequests =
                state.settings?.emergencyRequestsEnabled ?? true;
            final paymentNotifications =
                state.settings?.paymentNotificationsEnabled ?? false;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<SettingsBloc>().add(LoadSettingsEvent());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile/Hospital Card
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60.w,
                                height: 60.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2F6F9),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: const Icon(
                                  Icons.healing_outlined,
                                  color: Color(0xFF25C5D9),
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        final user = UserHiveHelper.getUser();
                                        final hospName =
                                            (user?.name?.isNotEmpty == true)
                                            ? user!.name!
                                            : ((user?.firstName?.isNotEmpty ==
                                                      true)
                                                  ? user!.firstName!
                                                  : context.strings.hospital);
                                        final hospPhone = user?.phone ?? '';
                                        final hospEmail = user?.email ?? '';

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    hospName,
                                                    style: context
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: const Color(
                                                            0xFF0F2D52,
                                                          ),
                                                        ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(width: 4.w),
                                                const Icon(
                                                  Icons.verified,
                                                  color: Colors.blue,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                            if (hospPhone.isNotEmpty) ...[
                                              SizedBox(height: 6.h),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone_outlined,
                                                    size: 14,
                                                    color: Color(0xFF7A8FA6),
                                                  ),
                                                  SizedBox(width: 6.w),
                                                  Text(
                                                    hospPhone,
                                                    style: context
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: const Color(
                                                            0xFF7A8FA6,
                                                          ),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            if (hospEmail.isNotEmpty) ...[
                                              SizedBox(height: 4.h),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.mail_outline_rounded,
                                                    size: 14,
                                                    color: Color(0xFF7A8FA6),
                                                  ),
                                                  SizedBox(width: 6.w),
                                                  Expanded(
                                                    child: Text(
                                                      hospEmail,
                                                      style: context
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                            color: const Color(
                                                              0xFF7A8FA6,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            width: double.infinity,
                            height: 40.h,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF1877F2),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                backgroundColor: const Color(0xFFF2F7FF),
                                elevation: 0,
                              ),
                              onPressed: () {
                                context.pushNamed(AppRoutes.profile);
                              },
                              child: Text(
                                context.strings.editProfile,
                                style: const TextStyle(
                                  color: Color(0xFF1877F2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Account Settings Section
                    SettingsSection(
                      title: context.strings.account,
                      children: [
                        SettingsActionTile(
                          icon: Icons.business_outlined,
                          title: context.strings.hospitalInformation,
                          onTap: () {
                            // Hospital Info page
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF1F5F9),
                        ),
                        SettingsActionTile(
                          icon: Icons.watch_later_outlined,
                          title: context.strings.workingHoursSettings,
                          onTap: () {
                            context.pushNamed(AppRoutes.scheduleManagement);
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF1F5F9),
                        ),
                        SettingsActionTile(
                          icon: Icons.notifications_active_outlined,
                          title: context.strings.notificationSettings,
                          onTap: () {
                            // Notification settings details
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF1F5F9),
                        ),
                        SettingsActionTile(
                          icon: Icons.language_outlined,
                          title: context.strings.language,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                currentLanguage == 'en' ? 'English' : 'العربية',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF7A8FA6),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              const Icon(
                                Icons.chevron_right_rounded,
                                size: 24,
                                color: Color(0xFF8E9BAE),
                              ),
                            ],
                          ),
                          onTap: () {
                            final newLang = currentLanguage == 'en'
                                ? 'ar'
                                : 'en';
                            context.read<SettingsBloc>().add(
                              ChangeLanguageEvent(languageCode: newLang),
                            );
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF1F5F9),
                        ),
                        SettingsActionTile(
                          icon: Icons.security_outlined,
                          title: context.strings.privacyPolicy,
                          onTap: () {
                            // Privacy policy
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF1F5F9),
                        ),
                        SettingsActionTile(
                          icon: Icons.description_outlined,
                          title: context.strings.termsAndConditions,
                          onTap: () {
                            // Terms and conditions
                          },
                        ),
                      ],
                    ),

                    // Alert Preferences Section
                    SettingsSection(
                      title: context.strings.alertPreferences,
                      children: [
                        SettingsSwitchTile(
                          title: context.strings.newBookings,
                          subtitle: context.strings.newBookingsDesc,
                          value: newBookings,
                          onChanged: (value) {
                            context.read<SettingsBloc>().add(
                              ToggleAlertPreferenceEvent(
                                type: AlertPreferenceType.newBookings,
                                isEnabled: value,
                              ),
                            );
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 16,
                          color: Color(0xFFF1F5F9),
                        ),
                        SettingsSwitchTile(
                          title: context.strings.appointmentReminders,
                          subtitle: context.strings.appointmentRemindersDesc,
                          value: appointmentReminders,
                          onChanged: (value) {
                            context.read<SettingsBloc>().add(
                              ToggleAlertPreferenceEvent(
                                type: AlertPreferenceType.appointmentReminders,
                                isEnabled: value,
                              ),
                            );
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 16,
                          color: Color(0xFFF1F5F9),
                        ),
                        SettingsSwitchTile(
                          title: context.strings.emergencyRequests,
                          subtitle: context.strings.emergencyRequestsDesc,
                          value: emergencyRequests,
                          onChanged: (value) {
                            context.read<SettingsBloc>().add(
                              ToggleAlertPreferenceEvent(
                                type: AlertPreferenceType.emergencyRequests,
                                isEnabled: value,
                              ),
                            );
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 16,
                          color: Color(0xFFF1F5F9),
                        ),
                        SettingsSwitchTile(
                          title: context.strings.paymentNotifications,
                          subtitle: context.strings.paymentNotificationsDesc,
                          value: paymentNotifications,
                          onChanged: (value) {
                            context.read<SettingsBloc>().add(
                              ToggleAlertPreferenceEvent(
                                type: AlertPreferenceType.paymentNotifications,
                                isEnabled: value,
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    // Security Section
                    SettingsSection(
                      title: context.strings.security,
                      children: [
                        SettingsActionTile(
                          icon: Icons.lock_reset_outlined,
                          title: context.strings.changePassword,
                          onTap: () {
                            // Change password flow
                          },
                        ),
                      ],
                    ),

                    // Marketing Text
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.strings.marketing.toUpperCase(),
                            style: context.textTheme.labelMedium?.copyWith(
                              color: const Color(0xFF7A8FA6),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          RichText(
                            text: TextSpan(
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF7A8FA6),
                                height: 1.3,
                              ),
                              children: [
                                TextSpan(
                                  text: context.strings.marketingContactText,
                                ),
                                TextSpan(
                                  text: context.strings.supportTeam,
                                  style: const TextStyle(
                                    color: Color(0xFF1877F2),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      SettingsContactSupportSheet.show(context);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Support Section
                    SettingsSection(
                      title: context.strings.support,
                      children: [
                        SettingsActionTile(
                          icon: Icons.help_outline,
                          title: context.strings.helpCenter,
                          onTap: () {},
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF1F5F9),
                        ),
                        SettingsActionTile(
                          icon: Icons.support_agent_outlined,
                          title: context.strings.contactSupport,
                          onTap: () {
                            SettingsContactSupportSheet.show(context);
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 56,
                          color: Color(0xFFF1F5F9),
                        ),
                        SettingsActionTile(
                          icon: Icons.info_outline,
                          title: context.strings.reportAProblem,
                          onTap: () {},
                        ),
                      ],
                    ),

                    // Payment Details Section
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 16.w,
                        bottom: 8.h,
                        top: 16.h,
                      ),
                      child: Text(
                        context.strings.paymentDetails,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: const Color(0xFF7A8FA6),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SettingsActionTile(
                        icon: Icons.account_balance_wallet_outlined,
                        title: context.strings.financialManagement,
                        onTap: () {
                          context.pushNamed(AppRoutes.financialManagement);
                        },
                      ),
                    ),

                    // Danger Zone Section
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 16.w,
                        bottom: 8.h,
                        top: 24.h,
                      ),
                      child: Text(
                        context.strings.dangerZone.toUpperCase(),
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Colors.red[700],
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      width: double.infinity,
                      height: 48.h,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red[700]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          backgroundColor: const Color(0xFFFFF5F5),
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            const LogoutSubmittedEvent(),
                          );
                          context.pushNamedAndRemoveUntil(AppRoutes.login);
                        },
                        icon: Icon(
                          Icons.logout_rounded,
                          color: Colors.red[700],
                        ),
                        label: Text(
                          context.strings.logOut,
                          style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          context.strings.deactivateAccount,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF7A8FA6),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
