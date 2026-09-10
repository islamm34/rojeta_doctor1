import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/profile_model.dart';
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
    return BlocProvider.value(value: _profileBloc, child: const ProfileView());
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _subSpecialtyController;
  late final TextEditingController _experienceController;
  late final TextEditingController _aboutController;
  late final TextEditingController _educationController;
  String? _lastProfileId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _subSpecialtyController = TextEditingController();
    _experienceController = TextEditingController();
    _aboutController = TextEditingController();
    _educationController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subSpecialtyController.dispose();
    _experienceController.dispose();
    _aboutController.dispose();
    _educationController.dispose();
    super.dispose();
  }

  void _syncControllers(ProfileModel profile) {
    _nameController.text = profile.fullName;
    _emailController.text = profile.email;
    _phoneController.text = profile.phone;
    _subSpecialtyController.text = profile.subSpecialty ?? '';
    _experienceController.text = profile.yearsOfExperience ?? '';
    _aboutController.text = profile.about ?? '';
    _educationController.text = profile.education ?? '';
    _lastProfileId = profile.id;
  }

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
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          if (state.status == ProfileStatus.success && state.profile != null) {
            _syncControllers(state.profile!);
          }
        },
        builder: (context, state) {
          if (state.status == ProfileStatus.loading && state.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.profile == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(const LoadProfileEvent());
                },
                child: Text(context.strings.retry),
              ),
            );
          }

          final profile = state.profile!;
          if (_lastProfileId == null) {
            _syncControllers(profile);
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProfileBloc>().add(const LoadProfileEvent());
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileHeaderCard(profile: profile),
                  const SizedBox(height: 16),
                  ProfileTabSwitcher(
                    isProfileSelected: state.isProfileTabSelected,
                    onTabChanged: (isProfile) {
                      context.read<ProfileBloc>().add(
                        SwitchTabEvent(isProfile),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  if (state.isProfileTabSelected) ...[
                    BasicInfoSection(
                      profile: profile,
                      nameController: _nameController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                    ),
                    const SizedBox(height: 16),
                    ProfessionalInfoSection(
                      profile: profile,
                      subSpecialtyController: _subSpecialtyController,
                      experienceController: _experienceController,
                      aboutController: _aboutController,
                      onSpecialtyChanged: (selectedSpecialty) {
                        if (selectedSpecialty != null) {
                          context.read<ProfileBloc>().add(
                            UpdateProfileDetailsEvent({
                              'specialty': selectedSpecialty.value,
                            }),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    EducationSection(
                      profile: profile,
                      educationController: _educationController,
                    ),
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
                        context.read<ProfileBloc>().add(
                          UpdateProfileDetailsEvent({
                            'name': _nameController.text.trim(),
                            'full_name': _nameController.text.trim(),
                            'email': _emailController.text.trim(),
                            'phone': _phoneController.text.trim(),
                            'phone_number': _phoneController.text.trim(),
                            'sub_specialty': _subSpecialtyController.text
                                .trim(),
                            'subSpecialty': _subSpecialtyController.text.trim(),
                            'years_of_experience': _experienceController.text
                                .trim(),
                            'yearsOfExperience': _experienceController.text
                                .trim(),
                            'about': _aboutController.text.trim(),
                            'bio': _aboutController.text.trim(),
                            'education': _educationController.text.trim(),
                          }),
                        );
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
            ),
          );
        },
      ),
    );
  }
}
