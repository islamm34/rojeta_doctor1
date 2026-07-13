import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import '../../../../../../features/auth/data/models/user_type_model.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../../../../../../core/di/injector.dart';

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
            if (state.status == SettingsStatus.initial || state.status == SettingsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            final settings = state.settings;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Notifications'),
                  _buildSettingsContainer(
                    children: [
                      _buildSwitchTile(
                        context,
                        title: 'Email Notifications',
                        value: settings.emailNotifications,
                        onChanged: (val) => context.read<SettingsBloc>().add(ToggleEmailNotifications(val)),
                      ),
                      _buildSwitchTile(
                        context,
                        title: 'Booking Updates',
                        value: settings.bookingUpdates,
                        onChanged: (val) => context.read<SettingsBloc>().add(ToggleBookingUpdates(val)),
                      ),
                      _buildSwitchTile(
                        context,
                        title: 'Push Notifications',
                        value: settings.pushNotifications,
                        onChanged: (val) => context.read<SettingsBloc>().add(TogglePushNotifications(val)),
                      ),
                      _buildSwitchTile(
                        context,
                        title: 'Appointment Reminders',
                        value: settings.appointmentReminders,
                        onChanged: (val) => context.read<SettingsBloc>().add(ToggleAppointmentReminders(val)),
                      ),
                      _buildSwitchTile(
                        context,
                        title: 'Marketing Emails',
                        value: settings.marketingEmails,
                        onChanged: null,
                        hasDivider: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  _buildSectionTitle(context, 'Security'),
                  _buildSettingsContainer(
                    children: [
                      _buildActionTile(context, title: 'Change Password', onTap: () {}),
                      _buildActionTile(context, title: 'Two-Factor Authentication', onTap: () {}, hasDivider: false),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  _buildSectionTitle(context, 'Privacy'),
                  _buildSettingsContainer(
                    children: [
                      _buildActionTile(context, title: 'Privacy Policy', onTap: () {}),
                      _buildActionTile(context, title: 'Terms & Conditions', onTap: () {}, hasDivider: false),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  _buildSectionTitle(context, 'Language'),
                  _buildSettingsContainer(
                    children: [
                      ListTile(
                        title: Text(
                          settings.language,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF0F2D52),
                          ),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF7A8FA6)),
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  _buildSectionTitle(context, 'Help & Support'),
                  _buildSettingsContainer(
                    children: [
                      _buildActionTile(context, title: 'Help Center', onTap: () {}),
                      _buildActionTile(context, title: 'Monthly statistics', onTap: () {}),
                      _buildActionTile(context, title: 'Contact Support', onTap: () {}),
                      _buildActionTile(context, title: 'About Rujeta', onTap: () {}, hasDivider: false),
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0F2D52),
        ),
      ),
    );
  }

  Widget _buildSettingsContainer({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required bool value,
    required ValueChanged<bool>? onChanged,
    bool hasDivider = true,
  }) {
    return Column(
      children: [
        SwitchListTile(
          value: value,
          onChanged: onChanged,
          title: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF0F2D52),
              fontWeight: FontWeight.w500,
            ),
          ),
          activeColor: Colors.white,
          activeTrackColor: const Color(0xFF1877F2),
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color(0xFFE2E8F0),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        if (hasDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xFFE2E8F0),
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
    bool hasDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF0F2D52),
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Color(0xFF7A8FA6)),
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        if (hasDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xFFE2E8F0),
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }
}
