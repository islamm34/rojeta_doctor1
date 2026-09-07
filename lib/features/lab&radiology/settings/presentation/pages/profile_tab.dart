import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import '../../../../../../features/auth/data/models/user_type_model.dart';
import '../../../../../../config/routes/app_router.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import 'widgets/settings_section.dart';
import 'widgets/profile_header_card.dart';
import '../../../../../../core/di/injector.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../auth/presentation/bloc/auth_event.dart';

class ProfileTab extends StatelessWidget {
  final UserType userType;

  const ProfileTab({super.key, required this.userType});

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
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text(
            'Profile',
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

            final profile = state.profile;
            if (profile == null) return const SizedBox();

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeaderCard(profile: profile),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: 'General Information',
                    children: [
                      SettingsItemTile(
                        icon: Icons.info_outline,
                        iconColor: const Color(0xFF0F2D52),
                        iconBgColor: const Color(0xFFE2E8F0),
                        title: userType == UserType.radiologyCenter ? 'Radiology Information' : 'Lab Information',
                        subtitle: 'Manage contact details and address',
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.labInfo,
                            extra: userType == UserType.radiologyCenter,
                          );
                        },
                      ),
                      SettingsItemTile(
                        icon: Icons.business_outlined,
                        iconColor: const Color(0xFF10B981),
                        iconBgColor: const Color(0xFFD1FAE5),
                        title: 'Branches',
                        subtitle:
                            'View and manage all ${profile.branchesCount} locations',
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.manageBranch,
                            extra: userType,
                          );
                        },
                      ),
                      SettingsItemTile(
                        icon: Icons.access_time,
                        iconColor: const Color(0xFF4B5563),
                        iconBgColor: const Color(0xFFE5E7EB),
                        title: 'Working Hours',
                        subtitle: 'Set operational times and holidays',
                        hasDivider: false,
                        onTap: () {
                          context.pushNamed(AppRoutes.workingHours);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: 'Compliance & Financials',
                    children: [
                      SettingsItemTile(
                        icon: Icons.folder_open_outlined,
                        iconColor: const Color(0xFF3B82F6),
                        iconBgColor: const Color(0xFFDBEAFE),
                        title: 'Documents',
                        subtitle: 'Licenses, certifications',
                        onTap: () {},
                      ),
                      SettingsItemTile(
                        icon: Icons.account_balance_outlined,
                        iconColor: const Color(0xFF14B8A6),
                        iconBgColor: const Color(0xFFCCFBF1),
                        title: 'Payout Settings',
                        subtitle: 'Manage bank accounts',
                        onTap: () {},
                      ),
                      SettingsItemTile(
                        icon: Icons.monetization_on_outlined,
                        iconColor: const Color(0xFFF59E0B),
                        iconBgColor: const Color(0xFFFEF3C7),
                        title: 'Earning',
                        subtitle: 'Financial Management',
                        hasDivider: false,
                        onTap: () {
                          context.pushNamed(AppRoutes.financialManagement);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  SettingsSection(
                    title: 'General Settings',
                    children: [
                      SettingsItemTile(
                        icon: Icons.settings_outlined,
                        iconColor: const Color(0xFF0EA5E9),
                        iconBgColor: Colors.transparent,
                        title: 'Account Preferences',
                        hasDivider: false,
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.generalSettings,
                            extra: userType,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2FE),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFBAE6FD)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support_agent_outlined,
                              color: const Color(0xFF0369A1),
                              size: 18.r,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Admin Support',
                              style: context.textTheme.labelMedium?.copyWith(
                                color: const Color(0xFF0369A1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Need help with your profile or documents?\nOur support team is available 24/7.',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF0F2D52),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1877F2),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: const Text(
                              'Contact Support',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

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
                        style: context.textTheme.titleSmall?.copyWith(
                          color: const Color(0xFFDC2626),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: const BorderSide(color: Color(0xFFDC2626)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        backgroundColor: Colors.white,
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
