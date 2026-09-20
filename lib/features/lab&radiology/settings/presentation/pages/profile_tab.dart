import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/doctor/profile/presentation/widgets/settings/settings_contact_support_sheet.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/di/injector.dart';
import '../../../../../../features/auth/data/models/user_type_model.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import 'widgets/admin_support_card.dart';
import 'widgets/profile_header_card.dart';
import 'widgets/settings_section.dart';

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
            context.strings.profile,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D52),
            ),
          ),
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state.status == SettingsStatus.initial ||
                (state.status == SettingsStatus.loading &&
                    state.profile == null)) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == SettingsStatus.failure &&
                state.profile == null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage ??
                            context.strings.somethingWentWrong,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () {
                          context.read<SettingsBloc>().add(LoadSettingsData());
                        },
                        child: Text(context.strings.retry),
                      ),
                    ],
                  ),
                ),
              );
            }

            final profile = state.profile;
            if (profile == null) return const SizedBox();

            return RefreshIndicator(
              onRefresh: () async {
                context.read<SettingsBloc>().add(LoadSettingsData());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeaderCard(profile: profile),
                    SizedBox(height: 24.h),

                    SettingsSection(
                      title: context.strings.generalInformation,
                      children: [
                        SettingsItemTile(
                          icon: Icons.info_outline,
                          iconColor: const Color(0xFF0F2D52),
                          iconBgColor: const Color(0xFFE2E8F0),
                          title: userType == UserType.radiologyCenter
                              ? context.strings.radiologyInformation
                              : context.strings.labInformation,
                          subtitle: context.strings.manageContactDetailsAndAddress,
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
                          title: context.strings.branches,
                          subtitle:
                              '${context.strings.branches} (${profile.branchesCount ?? 0})',
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
                          title: context.strings.workingHours,
                          subtitle: context.strings.setOperationalTimesAndHolidays,
                          hasDivider: false,
                          onTap: () {
                            context.pushNamed(AppRoutes.workingHours);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    SettingsSection(
                      title: context.strings.complianceAndFinancials,
                      children: [
                        SettingsItemTile(
                          icon: Icons.folder_open_outlined,
                          iconColor: const Color(0xFF3B82F6),
                          iconBgColor: const Color(0xFFDBEAFE),
                          title: context.strings.documents,
                          subtitle: context.strings.documentsSubtitle,
                          onTap: () {
                            final route = userType == UserType.radiologyCenter
                                ? AppRoutes.radiologyDocumentUpload
                                : AppRoutes.laboratoryDocumentUpload;
                            context.pushNamed(route);
                          },
                        ),
                        SettingsItemTile(
                          icon: Icons.account_balance_outlined,
                          iconColor: const Color(0xFF14B8A6),
                          iconBgColor: const Color(0xFFCCFBF1),
                          title: context.strings.payoutSettings,
                          subtitle: context.strings.payoutSettingsSubtitle,
                          onTap: () {
                            context.pushNamed(AppRoutes.financialManagement);
                          },
                        ),
                        SettingsItemTile(
                          icon: Icons.monetization_on_outlined,
                          iconColor: const Color(0xFFF59E0B),
                          iconBgColor: const Color(0xFFFEF3C7),
                          title: context.strings.earning,
                          subtitle: context.strings.financialManagementSubtitle,
                          hasDivider: false,
                          onTap: () {
                            context.pushNamed(AppRoutes.financialManagement);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    SettingsSection(
                      title: context.strings.generalSettings,
                      children: [
                        SettingsItemTile(
                          icon: Icons.settings_outlined,
                          iconColor: const Color(0xFF0EA5E9),
                          iconBgColor: Colors.transparent,
                          title: context.strings.accountPreferences,
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

                    AdminSupportCard(
                      onContactSupport: () {
                        SettingsContactSupportSheet.show(context);
                      },
                    ),
                    SizedBox(height: 24.h),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            const LogoutSubmittedEvent(),
                          );
                          context.pushNamedAndRemoveUntil(AppRoutes.login);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Color(0xFFDC2626),
                        ),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
