import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_tab_switcher.dart';
import '../widgets/basic_info_section.dart';
import '../widgets/professional_info_section.dart';
import '../widgets/education_section.dart';
import '../widgets/clinics_management_section.dart';
import '../widgets/services_pricing_section.dart';
import '../widgets/payment_details_section.dart';
import '../widgets/settings_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = injector<ProfileBloc>()..add(const LoadProfileEvent());
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileBloc,
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.3,
      ),
      appBar: AppBar(
        title: Text(
          context.strings.settings,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading ||
              state.status == ProfileStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.profile == null) {
            return const Center(child: Text('Failed to load profile.'));
          }

          final profile = state.profile!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHeaderCard(profile: profile),
                const SizedBox(height: 16),
                ProfileTabSwitcher(
                  isProfileSelected: state.isProfileTabSelected,
                  onTabChanged: (isProfile) {
                    context.read<ProfileBloc>().add(SwitchTabEvent(isProfile));
                  },
                ),
                const SizedBox(height: 24),
                if (state.isProfileTabSelected) ...[
                  BasicInfoSection(profile: profile),
                  const SizedBox(height: 16),
                  ProfessionalInfoSection(profile: profile),
                  const SizedBox(height: 16),
                  EducationSection(profile: profile),
                  const SizedBox(height: 16),
                  ClinicsManagementSection(profile: profile),
                  const SizedBox(height: 24),
                  ServicesPricingSection(profile: profile),
                  const SizedBox(height: 24),
                  PaymentDetailsSection(profile: profile),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    text: context.strings.saveProfile,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile saved successfully'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                ] else ...[
                  const SettingsView(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
