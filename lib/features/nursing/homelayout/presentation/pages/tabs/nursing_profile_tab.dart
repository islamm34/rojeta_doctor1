import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import '../../bloc/nursing_bloc.dart';
import '../../bloc/nursing_state.dart';

class NursingProfileTab extends StatelessWidget {
  const NursingProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Profile',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
        // If it's a tab, we typically don't have a back button, but screenshot shows one.
        // We'll leave it out or put a dummy if required, but standard tabs don't have back buttons.
      ),
      body: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          if (state.profile == null && state.status == NursingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.profile == null) {
            return const Center(child: Text('Failed to load profile'));
          }

          final profile = state.profile!;

          return SingleChildScrollView(
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
                              Container(
                                width: 64.w,
                                height: 64.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(profile.avatarUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                                  'License No: ${profile.licenseNumber}',
                                  style: context.textTheme.bodySmall?.copyWith(
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
                                    '${profile.servicesCount} Services',
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
                                    '${profile.nursesCount} Nurses',
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
                      _buildListItem(
                        context,
                        icon: Icons.business_outlined,
                        title: 'Office Information',
                        subtitle: 'Details, address, and contacts',
                        onTap: () => context.pushNamed(
                          AppRoutes.nursingOfficeInfo,
                          extra: context.read<NursingBloc>(),
                        ),
                      ),
                      _buildDivider(),
                      _buildListItem(
                        context,
                        icon: Icons.map_outlined,
                        title: 'Coverage Areas',
                        subtitle: 'Manage service locations',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildListItem(
                        context,
                        icon: Icons.access_time_outlined,
                        title: 'Working Hours',
                        subtitle: 'Staff shifts and office hours',
                        onTap: () => context.pushNamed(
                          AppRoutes.nursingWorkingHours,
                          extra: context.read<NursingBloc>(),
                        ),
                      ),
                      _buildDivider(),
                      _buildListItem(
                        context,
                        icon: Icons.description_outlined,
                        title: 'Documents',
                        subtitle: 'Licenses and certifications',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildListItem(
                        context,
                        icon: Icons.account_balance_outlined,
                        title: 'Payment Settings',
                        subtitle: 'Banking and payment methods',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildListItem(
                        context,
                        icon: Icons.monetization_on_outlined,
                        title: 'Earning',
                        subtitle: 'Financial Management',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildListItem(
                        context,
                        icon: Icons.settings_outlined,
                        title: 'Settings',
                        subtitle: 'App preferences and security',
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
                            'Admin Support',
                            style: context.textTheme.titleSmall?.copyWith(
                              color: const Color(0xFF0284C7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Need help with your profile or documents?\nOur support team is available 24/7.',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF0F2D52),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          minimumSize: Size(double.infinity, 44.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Contact Support',
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
                  onPressed: () {},
                  icon: const Icon(Icons.logout, color: Color(0xFFEF4444)),
                  label: Text(
                    'Logout',
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
          );
        },
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? BorderRadius.vertical(bottom: Radius.circular(16.r))
          : BorderRadius.zero,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: const Color(0xFF3B82F6), size: 20.w),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF94A3B8),
              size: 24.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: const Color(0xFFF1F5F9),
      indent: 64.w,
    );
  }
}
