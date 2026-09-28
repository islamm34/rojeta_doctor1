import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/doctor/profile/presentation/widgets/settings/settings_contact_support_sheet.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_event.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../../auth/presentation/bloc/auth_event.dart';
import '../../bloc/nursing_bloc.dart';
import '../../bloc/nursing_state.dart';
import 'widgets/nursing_profile_divider.dart';
import 'widgets/nursing_profile_list_item.dart';

class NursingProfileTab extends StatelessWidget {
  const NursingProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          strings.profile,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
      ),
      body: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          if (state.profile == null && state.status == NursingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.profile == null) {
            return Center(child: Text(strings.noDataAvailable));
          }

          final profile = state.profile!;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<NursingBloc>().add(LoadNursingProfileEvent());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Profile Header Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 32.w,
                                  backgroundColor: const Color(0xFFEFF6FF),
                                  backgroundImage:
                                      profile.avatarUrl.isNotEmpty &&
                                          profile.avatarUrl.startsWith('http')
                                      ? NetworkImage(profile.avatarUrl)
                                      : null,
                                  onBackgroundImageError:
                                      profile.avatarUrl.isNotEmpty &&
                                          profile.avatarUrl.startsWith('http')
                                      ? (_, _) {}
                                      : null,
                                  child:
                                      profile.avatarUrl.isEmpty ||
                                          !profile.avatarUrl.startsWith('http')
                                      ? Icon(
                                          Icons.person,
                                          size: 32.w,
                                          color: const Color(0xFF0EA5E9),
                                        )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(2.w),
                                    child: Icon(
                                      Icons.verified,
                                      color: const Color(0xFF0EA5E9),
                                      size: 20.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile.name,
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF0F172A),
                                        ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${strings.licenseNumber}: ${profile.licenseNumber}',
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color: const Color(0xFF64748B),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.medical_services_outlined,
                                      color: const Color(0xFF0F2D52),
                                      size: 16.w,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      '${profile.servicesCount} ${strings.services}',
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                            color: const Color(0xFF0F2D52),
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.people_outline,
                                      color: const Color(0xFF0F2D52),
                                      size: 16.w,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      '${profile.nursesCount} ${strings.nurses}',
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                            color: const Color(0xFF0F2D52),
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Settings List
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        NursingProfileListItem(
                          icon: Icons.business_outlined,
                          title: strings.officeInformation,
                          subtitle: strings.officeInformationDesc,
                          onTap: () => context.pushNamed(
                            AppRoutes.nursingOfficeInfo,
                            extra: context.read<NursingBloc>(),
                          ),
                        ),
                        const NursingProfileDivider(),
                        NursingProfileListItem(
                          icon: Icons.map_outlined,
                          title: strings.coverageAreas,
                          subtitle: strings.coverageAreasDesc,
                          onTap: () {},
                        ),
                        const NursingProfileDivider(),
                        NursingProfileListItem(
                          icon: Icons.access_time_outlined,
                          title: strings.workingHours,
                          subtitle: strings.workingHoursDesc,
                          onTap: () => context.pushNamed(
                            AppRoutes.nursingWorkingHours,
                            extra: context.read<NursingBloc>(),
                          ),
                        ),
                        const NursingProfileDivider(),
                        NursingProfileListItem(
                          icon: Icons.description_outlined,
                          title: strings.documents,
                          subtitle: strings.documentsDesc,
                          onTap: () {},
                        ),
                        const NursingProfileDivider(),
                        NursingProfileListItem(
                          icon: Icons.account_balance_outlined,
                          title: strings.paymentSettings,
                          subtitle: strings.paymentSettingsDesc,
                          onTap: () {},
                        ),
                        const NursingProfileDivider(),
                        NursingProfileListItem(
                          icon: Icons.monetization_on_outlined,
                          title: strings.earnings,
                          subtitle: strings.financialManagement,
                          onTap: () {
                            context.pushNamed(AppRoutes.financialManagement);
                          },
                        ),
                        const NursingProfileDivider(),
                        NursingProfileListItem(
                          icon: Icons.settings_outlined,
                          title: strings.settings,
                          subtitle: strings.settingsDesc,
                          onTap: () => context.pushNamed(
                            AppRoutes.nursingSettings,
                            extra: context.read<NursingBloc>(),
                          ),
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Admin Support Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2FE),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFFBAE6FD)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support_agent,
                              color: const Color(0xFF0284C7),
                              size: 20.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              strings.adminSupport,
                              style: context.textTheme.titleSmall?.copyWith(
                                color: const Color(0xFF0284C7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          strings.adminSupportDesc,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF0F2D52),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () =>
                              SettingsContactSupportSheet.show(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            minimumSize: Size(double.infinity, 44.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            strings.contactSupport,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Logout Button
                  OutlinedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        const LogoutSubmittedEvent(),
                      );
                      context.pushNamedAndRemoveUntil(AppRoutes.login);
                    },
                    icon: const Icon(Icons.logout, color: Color(0xFFEF4444)),
                    label: Text(
                      strings.logOut,
                      style: TextStyle(
                        color: const Color(0xFFEF4444),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.h),
                      side: const BorderSide(color: Color(0xFFEF4444)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
