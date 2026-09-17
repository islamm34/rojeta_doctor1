import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

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

  @override
  Widget build(BuildContext context) {
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
            'Settings',
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
                    title: 'Notifications',
                    children: [
                      SettingsSwitchTile(
                        title: 'Email Notifications',
                        value: settings.emailNotifications ?? false,
                        onChanged: (val) => context.read<SettingsBloc>().add(
                          ToggleEmailNotifications(val),
                        ),
                      ),
                      SettingsSwitchTile(
                        title: 'Booking Updates',
                        value: settings.bookingUpdates ?? false,
                        onChanged: (val) => context.read<SettingsBloc>().add(
                          ToggleBookingUpdates(val),
                        ),
                      ),
                      SettingsSwitchTile(
                        title: 'Push Notifications',
                        value: settings.pushNotifications ?? false,
                        onChanged: (val) => context.read<SettingsBloc>().add(
                          TogglePushNotifications(val),
                        ),
                      ),
                      SettingsSwitchTile(
                        title: 'Appointment Reminders',
                        value: settings.appointmentReminders ?? false,
                        onChanged: (val) => context.read<SettingsBloc>().add(
                          ToggleAppointmentReminders(val),
                        ),
                      ),
                      SettingsSwitchTile(
                        title: 'Marketing Emails',
                        value: settings.marketingEmails ?? false,
                        onChanged: null,
                        hasDivider: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: 'Security',
                    children: [
                      SettingsActionTile(
                        title: 'Change Password',
                        onTap: () {},
                      ),
                      SettingsActionTile(
                        title: 'Two-Factor Authentication',
                        onTap: () {},
                        hasDivider: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: 'Privacy',
                    children: [
                      SettingsActionTile(title: 'Privacy Policy', onTap: () {}),
                      SettingsActionTile(
                        title: 'Terms & Conditions',
                        onTap: () {},
                        hasDivider: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: 'Language',
                    children: [
                      ListTile(
                        title: Text(
                          settings.language ?? '',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF0F2D52),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF7A8FA6),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: 'Help & Support',
                    children: [
                      SettingsActionTile(title: 'Help Center', onTap: () {}),
                      SettingsActionTile(
                        title: 'Monthly statistics',
                        onTap: () {},
                      ),
                      SettingsActionTile(
                        title: 'Contact Support',
                        onTap: () {},
                      ),
                      SettingsActionTile(
                        title: 'About Rujeta',
                        onTap: () {},
                        hasDivider: false,
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),
                  Center(
                    child: Text(
                      'Rujeta Doctor App Version 1.0.0',
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
