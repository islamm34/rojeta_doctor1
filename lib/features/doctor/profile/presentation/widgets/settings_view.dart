import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import '../../../../../../config/routes/app_router.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import '../../../../../../core/local/user_hive_helper.dart';

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
            _buildSectionCard(
              context: context,
              icon: Icons.notifications_none,
              title: context.strings.notifications,
              children: [
                _buildSwitchTile(
                  context: context,
                  title: context.strings.emailNotifications,
                  subtitle: context.strings.emailNotificationsDesc,
                  value: settings.emailNotifications,
                  onChanged: (val) {
                    context.read<ProfileBloc>().add(
                      ToggleSettingEvent('emailNotifications', val),
                    );
                  },
                ),
                _buildDivider(),
                _buildSwitchTile(
                  context: context,
                  title: context.strings.smsNotifications,
                  subtitle: context.strings.smsNotificationsDesc,
                  value: settings.smsNotifications,
                  onChanged: (val) {
                    context.read<ProfileBloc>().add(
                      ToggleSettingEvent('smsNotifications', val),
                    );
                  },
                ),
                _buildDivider(),
                _buildSwitchTile(
                  context: context,
                  title: context.strings.pushNotifications,
                  subtitle: context.strings.pushNotificationsDesc,
                  value: settings.pushNotifications,
                  onChanged: (val) {
                    context.read<ProfileBloc>().add(
                      ToggleSettingEvent('pushNotifications', val),
                    );
                  },
                ),
                _buildDivider(),
                _buildSwitchTile(
                  context: context,
                  title: context.strings.appointmentReminders,
                  subtitle: context.strings.appointmentRemindersDesc,
                  value: settings.appointmentReminders,
                  onChanged: (val) {
                    context.read<ProfileBloc>().add(
                      ToggleSettingEvent('appointmentReminders', val),
                    );
                  },
                ),
                _buildDivider(),
                _buildSwitchTile(
                  context: context,
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
            _buildSectionCard(
              context: context,
              icon: Icons.lock_outline,
              title: context.strings.security,
              children: [
                _buildNavigationTile(
                  context: context,
                  title: context.strings.changePassword,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _buildNavigationTile(
                  context: context,
                  title: context.strings.twoFactorAuth,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              context: context,
              icon: Icons.shield_outlined,
              title: context.strings.privacy,
              children: [
                _buildNavigationTile(
                  context: context,
                  title: context.strings.privacyPolicy,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _buildNavigationTile(
                  context: context,
                  title: context.strings.termsAndConditions,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              context: context,
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
            _buildMarketingCard(context),
            const SizedBox(height: 16),
            _buildSectionCard(
              context: context,
              icon: Icons.help_outline,
              title: context.strings.helpAndSupport,
              children: [
                _buildNavigationTile(
                  context: context,
                  title: context.strings.helpCenter,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _buildNavigationTile(
                  context: context,
                  title: context.strings.monthlyStatistics,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _buildNavigationTile(
                  context: context,
                  title: context.strings.contactSupport,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _buildNavigationTile(
                  context: context,
                  title: context.strings.aboutRujeta,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildFooter(context),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }

  Widget _buildMarketingCard(BuildContext context) {
    final theme = Theme.of(context);
    final pinkColor = const Color(0xFFD61A8A);
    final lightPinkColor = const Color(0xFFFDF0F6);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightPinkColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: pinkColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: pinkColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.campaign,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.strings.marketingAndPromotion,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      context.strings.marketingSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            context.strings.marketingDesc,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          _buildMarketingListItem(
            context,
            Icons.share,
            context.strings.marketingPoint1,
            pinkColor,
          ),
          _buildMarketingListItem(
            context,
            Icons.campaign_outlined,
            context.strings.marketingPoint2,
            pinkColor,
          ),
          _buildMarketingListItem(
            context,
            Icons.analytics_outlined,
            context.strings.marketingPoint3,
            pinkColor,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                context.pushNamed(AppRoutes.marketingPackages);
              },
              icon: const Icon(Icons.campaign, color: Colors.white),
              label: Text(
                context.strings.viewMarketingPackages,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: pinkColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketingListItem(
    BuildContext context,
    IconData icon,
    String text,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            context.strings.rujetaDoctorApp,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.strings.version,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: theme.colorScheme.primary,
            inactiveTrackColor: Colors.grey.shade300,
            inactiveThumbColor: Colors.white,
            trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
              states,
            ) {
              if (!states.contains(WidgetState.selected)) {
                return Colors.grey.shade300;
              }
              return Colors.transparent;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.3,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: Colors.grey.shade100, height: 1),
    );
  }
}
