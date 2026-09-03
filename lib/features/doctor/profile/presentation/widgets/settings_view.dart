import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/features/doctor/profile/presentation/bloc/profile/profile_state.dart';
import '../../../../../../config/routes/app_router.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../../../../../../core/local/user_hive_helper.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../auth/presentation/bloc/auth_event.dart';
import 'settings/settings_footer.dart';
import 'settings/settings_marketing_banner_card.dart';
import 'settings/settings_navigation_tile.dart';
import 'settings/settings_section_card.dart';
import 'settings/settings_switch_tile.dart';
import 'settings/settings_tile_divider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final settings = state.settings;
        final theme = Theme.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsSectionCard(
              icon: Icons.notifications_none,
              title: context.strings.notifications,
              children: [
                SettingsSwitchTile(
                  title: context.strings.emailNotifications,
                  subtitle: context.strings.emailNotificationsDesc,
                  value: settings.emailNotifications,
                  onChanged: (val) {
                    context.read<ProfileBloc>().add(
                          ToggleSettingEvent('emailNotifications', val),
                        );
                  },
                ),
                const SettingsTileDivider(),
                SettingsSwitchTile(
                  title: context.strings.smsNotifications,
                  subtitle: context.strings.smsNotificationsDesc,
                  value: settings.smsNotifications,
                  onChanged: (val) {
                    context.read<ProfileBloc>().add(
                          ToggleSettingEvent('smsNotifications', val),
                        );
                  },
                ),
                const SettingsTileDivider(),
                SettingsSwitchTile(
                  title: context.strings.pushNotifications,
                  subtitle: context.strings.pushNotificationsDesc,
                  value: settings.pushNotifications,
                  onChanged: (val) {
                    context.read<ProfileBloc>().add(
                          ToggleSettingEvent('pushNotifications', val),
                        );
                  },
                ),
                const SettingsTileDivider(),
                SettingsSwitchTile(
                  title: context.strings.appointmentReminders,
                  subtitle: context.strings.appointmentRemindersDesc,
                  value: settings.appointmentReminders,
                  onChanged: (val) {
                    context.read<ProfileBloc>().add(
                          ToggleSettingEvent('appointmentReminders', val),
                        );
                  },
                ),
                const SettingsTileDivider(),
                SettingsSwitchTile(
                  title: context.strings.marketingEmails,
                  subtitle: context.strings.marketingEmailsDesc,
                  value: settings.marketingEmails,
                  onChanged: (val) {
                    context.read<ProfileBloc>().add(
                          ToggleSettingEvent('marketingEmails', val),
                        );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SettingsSectionCard(
              icon: Icons.lock_outline,
              title: context.strings.security,
              children: [
                SettingsNavigationTile(
                  title: context.strings.changePassword,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                SettingsNavigationTile(
                  title: context.strings.twoFactorAuth,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            SettingsSectionCard(
              icon: Icons.shield_outlined,
              title: context.strings.privacy,
              children: [
                SettingsNavigationTile(
                  title: context.strings.privacyPolicy,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                SettingsNavigationTile(
                  title: context.strings.termsAndConditions,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            SettingsSectionCard(
              icon: Icons.language,
              title: context.strings.language,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: Localizations.localeOf(context).languageCode,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      items: const [
                        DropdownMenuItem(value: 'ar', child: Text('العربية')),
                        DropdownMenuItem(value: 'en', child: Text('English')),
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
            const SizedBox(height: 16),
            const SettingsMarketingBannerCard(),
            const SizedBox(height: 16),
            SettingsSectionCard(
              icon: Icons.help_outline,
              title: context.strings.helpAndSupport,
              children: [
                SettingsNavigationTile(
                  title: context.strings.helpCenter,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                SettingsNavigationTile(
                  title: context.strings.monthlyStatistics,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                SettingsNavigationTile(
                  title: context.strings.contactSupport,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                SettingsNavigationTile(
                  title: context.strings.aboutRujeta,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(const LogoutSubmittedEvent());
                  context.pushNamedAndRemoveUntil(AppRoutes.login);
                },
                icon: const Icon(Icons.logout, color: Color(0xFFDC2626)),
                label: Text(
                  context.strings.logOut,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: const Color(0xFFDC2626),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Color(0xFFDC2626)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFFFFF5F5),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const SettingsFooter(),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }
}
