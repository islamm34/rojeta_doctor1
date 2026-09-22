import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/local/user_hive_helper.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/doctor/profile/presentation/widgets/settings/settings_about_sheet.dart';
import 'package:rojeta_doctor/features/doctor/profile/presentation/widgets/settings/settings_change_password_sheet.dart';
import 'package:rojeta_doctor/features/doctor/profile/presentation/widgets/settings/settings_contact_support_sheet.dart';

import '../../../../../../core/di/injector.dart';
import '../../../../../../features/auth/data/models/user_type_model.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import 'widgets/settings_action_tile.dart';
import 'widgets/settings_section.dart';
import 'widgets/settings_switch_tile.dart';

class GeneralSettingsPage extends StatelessWidget {
  final UserType userType;

  const GeneralSettingsPage({super.key, required this.userType});

  void _showLanguageDialog(BuildContext context) {
    final currentLang = UserHiveHelper.getUser()?.language ?? 'ar';

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) {
        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.language,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2D52),
                  ),
                ),
                SizedBox(height: 16.h),
                ListTile(
                  title: const Text('العربية'),
                  trailing: currentLang == 'ar'
                      ? const Icon(Icons.check_circle, color: Color(0xFF1877F2))
                      : null,
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    final user = UserHiveHelper.getUser();
                    if (user != null) {
                      UserHiveHelper.updateUser(user.copyWith(language: 'ar'));
                    }
                  },
                ),
                ListTile(
                  title: const Text('English'),
                  trailing: currentLang == 'en'
                      ? const Icon(Icons.check_circle, color: Color(0xFF1877F2))
                      : null,
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    final user = UserHiveHelper.getUser();
                    if (user != null) {
                      UserHiveHelper.updateUser(user.copyWith(language: 'en'));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showInfoDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(context.strings.close),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = UserHiveHelper.getUser()?.language ?? 'ar';

    return BlocProvider(
      create: (context) => injector<SettingsBloc>()..add(LoadSettingsData()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            context.strings.generalSettings,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D52),
            ),
          ),
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state.status == SettingsStatus.initial ||
                state.status == SettingsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            final settings = state.settings;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsSection(
                    title: context.strings.notificationSettings,
                    children: [
                      SettingsSwitchTile(
                        title: context.strings.emailNotifications,
                        value: settings.emailNotifications ?? false,
                        onChanged: (val) => context.read<SettingsBloc>().add(
                          ToggleEmailNotifications(val),
                        ),
                      ),
                      SettingsSwitchTile(
                        title: context.strings.bookingUpdates,
                        value: settings.bookingUpdates ?? false,
                        onChanged: (val) => context.read<SettingsBloc>().add(
                          ToggleBookingUpdates(val),
                        ),
                      ),
                      SettingsSwitchTile(
                        title: context.strings.pushNotifications,
                        value: settings.pushNotifications ?? false,
                        onChanged: (val) => context.read<SettingsBloc>().add(
                          TogglePushNotifications(val),
                        ),
                      ),
                      SettingsSwitchTile(
                        title: context.strings.appointmentReminders,
                        value: settings.appointmentReminders ?? false,
                        onChanged: (val) => context.read<SettingsBloc>().add(
                          ToggleAppointmentReminders(val),
                        ),
                      ),
                      SettingsSwitchTile(
                        title: context.strings.marketingEmails,
                        value: settings.marketingEmails ?? false,
                        onChanged: null,
                        hasDivider: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: context.strings.security,
                    children: [
                      SettingsActionTile(
                        title: context.strings.changePassword,
                        onTap: () {
                          SettingsChangePasswordSheet.show(context);
                        },
                      ),
                      SettingsActionTile(
                        title: context.strings.twoFactorAuthentication,
                        onTap: () {
                          _showInfoDialog(
                            context,
                            context.strings.twoFactorAuthentication,
                            context.strings.keepNotificationsTurnedOn,
                          );
                        },
                        hasDivider: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: context.strings.privacyPolicy,
                    children: [
                      SettingsActionTile(
                        title: context.strings.privacyPolicy,
                        onTap: () {
                          _showInfoDialog(
                            context,
                            context.strings.privacyPolicy,
                            context.strings.yourPaymentDetailsAreSecure,
                          );
                        },
                      ),
                      SettingsActionTile(
                        title: context.strings.termsAndConditions,
                        onTap: () {
                          _showInfoDialog(
                            context,
                            context.strings.termsAndConditions,
                            context.strings.doctorDirectoryNotice,
                          );
                        },
                        hasDivider: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: context.strings.language,
                    children: [
                      ListTile(
                        title: Text(
                          currentLang == 'ar' ? 'العربية' : 'English',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF0F2D52),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF7A8FA6),
                        ),
                        onTap: () => _showLanguageDialog(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: context.strings.support,
                    children: [
                      SettingsActionTile(
                        title: context.strings.helpCenter,
                        onTap: () {
                          SettingsContactSupportSheet.show(context);
                        },
                      ),
                      SettingsActionTile(
                        title: context.strings.contactSupport,
                        onTap: () {
                          SettingsContactSupportSheet.show(context);
                        },
                      ),
                      SettingsActionTile(
                        title: context.strings.aboutRujeta,
                        onTap: () {
                          SettingsAboutSheet.show(context);
                        },
                        hasDivider: false,
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),
                  Center(
                    child: Text(
                      context.strings.appVersion,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
