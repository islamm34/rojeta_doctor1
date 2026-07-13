import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_event.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_state.dart';

class NursingSettingsPage extends StatelessWidget {
  const NursingSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Settings',
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
          if (state.settings == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final settings = state.settings!;

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
                _buildSectionContainer(
                  title: 'Notifications',
                  icon: Icons.notifications_outlined,
                  children: [
                    _buildSwitchItem(
                      context,
                      title: 'Email Notifications',
                      subtitle: 'Receive notifications via email',
                      value: settings.emailNotifications,
                      onChanged: (val) {
                        updateSettings(
                          settings.copyWith(emailNotifications: val),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchItem(
                      context,
                      title: 'Booking Updates',
                      subtitle: 'Receive SMS for important updates',
                      value: settings.bookingUpdates,
                      onChanged: (val) {
                        updateSettings(settings.copyWith(bookingUpdates: val));
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchItem(
                      context,
                      title: 'Push Notifications',
                      subtitle: 'Receive push notifications on your device',
                      value: settings.pushNotifications,
                      onChanged: (val) {
                        updateSettings(
                          settings.copyWith(pushNotifications: val),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchItem(
                      context,
                      title: 'Appointment Reminders',
                      subtitle: 'Get reminders before appointments',
                      value: settings.appointmentReminders,
                      onChanged: (val) {
                        updateSettings(
                          settings.copyWith(appointmentReminders: val),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchItem(
                      context,
                      title: 'Marketing Emails',
                      subtitle: 'Receive promotional and marketing emails',
                      value: settings.marketingEmails,
                      onChanged: (val) {
                        updateSettings(settings.copyWith(marketingEmails: val));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Security Section
                _buildSectionContainer(
                  title: 'Security',
                  icon: Icons.lock_outline,
                  children: [
                    _buildNavigationItem(context, title: 'Change Password'),
                    SizedBox(height: 8.h),
                    _buildNavigationItem(
                      context,
                      title: 'Two-Factor Authentication',
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Privacy Section
                _buildSectionContainer(
                  title: 'Privacy',
                  icon: Icons.shield_outlined,
                  children: [
                    _buildNavigationItem(context, title: 'Privacy Policy'),
                    SizedBox(height: 8.h),
                    _buildNavigationItem(context, title: 'Terms & Conditions'),
                  ],
                ),
                SizedBox(height: 16.h),

                // Language Section
                _buildSectionContainer(
                  title: 'Language',
                  icon: Icons.language,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'English',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: const Color(0xFF64748B),
                            size: 20.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Help & Support Section
                _buildSectionContainer(
                  title: 'Help & Support',
                  icon: Icons.help_outline,
                  children: [
                    _buildNavigationItem(context, title: 'Help Center'),
                    SizedBox(height: 8.h),
                    _buildNavigationItem(context, title: 'Monthly statistics'),
                    SizedBox(height: 8.h),
                    _buildNavigationItem(context, title: 'Contact Support'),
                    SizedBox(height: 8.h),
                    _buildNavigationItem(context, title: 'About Rujeta'),
                  ],
                ),
                SizedBox(height: 32.h),

                // Version text
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Rujeta Doctor App',
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

  Widget _buildSectionContainer({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF3B82F6), size: 20.w),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF0F172A),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF64748B),
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF2563EB),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFE2E8F0),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(BuildContext context, {required String title}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF475569),
            ),
          ),
          Icon(Icons.chevron_right, color: const Color(0xFF94A3B8), size: 20.w),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 16.h, thickness: 1, color: const Color(0xFFF1F5F9));
  }
}
