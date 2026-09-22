import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/local/user_hive_helper.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../doctor/profile/presentation/widgets/settings/settings_about_sheet.dart';
import '../../../../../doctor/profile/presentation/widgets/settings/settings_change_password_sheet.dart';
import '../../../../../doctor/profile/presentation/widgets/settings/settings_contact_support_sheet.dart';
import '../../../../../doctor/profile/presentation/widgets/settings/settings_help_center_sheet.dart';
import '../../../../../doctor/profile/presentation/widgets/settings/settings_legal_sheet.dart';
import '../../../../../doctor/profile/presentation/widgets/settings/settings_two_factor_sheet.dart';
import '../../bloc/nursing_bloc.dart';
import '../../bloc/nursing_event.dart';
import '../../bloc/nursing_state.dart';
import 'widgets/nursing_settings_nav_item.dart';
import 'widgets/nursing_settings_section_container.dart';
import 'widgets/nursing_settings_switch_item.dart';

class NursingSettingsPage extends StatelessWidget {
  const NursingSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          strings.settings,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          if (state.settings == null && state.status == NursingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final settings = state.settings ?? const NursingSettingsModel();

          void updateSettings(NursingSettingsModel updatedSettings) {
            context.read<NursingBloc>().add(
              UpdateNursingSettingsEvent(updatedSettings),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Notifications Section
                NursingSettingsSectionContainer(
                  title: strings.notifications,
                  icon: Icons.notifications_outlined,
                  children: [
                    NursingSettingsSwitchItem(
                      title: strings.emailNotifications,
                      subtitle: strings.emailNotificationsDesc,
                      value: settings.emailNotifications,
                      onChanged: (val) {
                        updateSettings(
                          settings.copyWith(emailNotifications: val),
                        );
                      },
                    ),
                    Divider(
                      height: 16.h,
                      thickness: 1,
                      color: const Color(0xFFF1F5F9),
                    ),
                    NursingSettingsSwitchItem(
                      title: strings.smsNotifications,
                      subtitle: strings.smsNotificationsDesc,
                      value: settings.bookingUpdates,
                      onChanged: (val) {
                        updateSettings(settings.copyWith(bookingUpdates: val));
                      },
                    ),
                    Divider(
                      height: 16.h,
                      thickness: 1,
                      color: const Color(0xFFF1F5F9),
                    ),
                    NursingSettingsSwitchItem(
                      title: strings.pushNotifications,
                      subtitle: strings.pushNotificationsDesc,
                      value: settings.pushNotifications,
                      onChanged: (val) {
                        updateSettings(
                          settings.copyWith(pushNotifications: val),
                        );
                      },
                    ),
                    Divider(
                      height: 16.h,
                      thickness: 1,
                      color: const Color(0xFFF1F5F9),
                    ),
                    NursingSettingsSwitchItem(
                      title: strings.appointmentReminders,
                      subtitle: strings.appointmentRemindersDesc,
                      value: settings.appointmentReminders,
                      onChanged: (val) {
                        updateSettings(
                          settings.copyWith(appointmentReminders: val),
                        );
                      },
                    ),
                    Divider(
                      height: 16.h,
                      thickness: 1,
                      color: const Color(0xFFF1F5F9),
                    ),
                    NursingSettingsSwitchItem(
                      title: strings.marketingEmails,
                      subtitle: strings.marketingEmailsDesc,
                      value: settings.marketingEmails,
                      onChanged: (val) {
                        updateSettings(settings.copyWith(marketingEmails: val));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Security Section
                NursingSettingsSectionContainer(
                  title: strings.security,
                  icon: Icons.lock_outline,
                  children: [
                    NursingSettingsNavItem(
                      title: strings.changePassword,
                      onTap: () => SettingsChangePasswordSheet.show(context),
                    ),
                    SizedBox(height: 8.h),
                    NursingSettingsNavItem(
                      title: strings.twoFactorAuth,
                      onTap: () => SettingsTwoFactorSheet.show(context),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Privacy Section
                NursingSettingsSectionContainer(
                  title: strings.privacy,
                  icon: Icons.shield_outlined,
                  children: [
                    NursingSettingsNavItem(
                      title: strings.privacyPolicy,
                      onTap: () => SettingsLegalSheet.show(
                        context,
                        title: strings.privacyPolicy,
                        content:
                            'At Rojeta, we take your privacy and the confidentiality of medical data seriously. All patient records, consultations, and nursing schedules are encrypted and processed in compliance with healthcare data protection standards.',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    NursingSettingsNavItem(
                      title: strings.termsAndConditions,
                      onTap: () => SettingsLegalSheet.show(
                        context,
                        title: strings.termsAndConditions,
                        content:
                            'By using the Rojeta Nursing Provider platform, you agree to provide certified nursing staff, maintain professional medical standards, and honor confirmed service bookings according to your published schedule.',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Language Section
                NursingSettingsSectionContainer(
                  title: strings.language,
                  icon: Icons.language,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: Localizations.localeOf(context).languageCode,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          items: const [
                            DropdownMenuItem(
                              value: 'ar',
                              child: Text('العربية'),
                            ),
                            DropdownMenuItem(
                              value: 'en',
                              child: Text('English'),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              final user = UserHiveHelper.getUser();
                              if (user != null) {
                                user.languageSetter = newValue;
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Help & Support Section
                NursingSettingsSectionContainer(
                  title: strings.helpAndSupport,
                  icon: Icons.help_outline,
                  children: [
                    NursingSettingsNavItem(
                      title: strings.helpCenter,
                      onTap: () => SettingsHelpCenterSheet.show(context),
                    ),
                    SizedBox(height: 8.h),
                    NursingSettingsNavItem(
                      title: strings.monthlyStatistics,
                      onTap: () =>
                          context.pushNamed(AppRoutes.financialManagement),
                    ),
                    SizedBox(height: 8.h),
                    NursingSettingsNavItem(
                      title: strings.contactSupport,
                      onTap: () => SettingsContactSupportSheet.show(context),
                    ),
                    SizedBox(height: 8.h),
                    NursingSettingsNavItem(
                      title: strings.aboutRujeta,
                      onTap: () => SettingsAboutSheet.show(context),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Version text
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Rujeta Nursing Provider App',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        'Version 1.0.0',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF94A3B8),
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
