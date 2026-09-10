import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import '../../../../../config/routes/app_router.dart';
import '../../data/models/clinic_model.dart';
import '../../data/models/profile_model.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import 'clinic_delete_confirm_dialog.dart';
import 'clinic_list_item_card.dart';

class ClinicsManagementSection extends StatelessWidget {
  final ProfileModel profile;

  const ClinicsManagementSection({super.key, required this.profile});

  Future<void> _openAddClinic(BuildContext context) async {
    final result = await context.pushNamed(AppRoutes.addClinic);
    if (result == true && context.mounted) {
      context.read<ProfileBloc>().add(const LoadProfileEvent());
    }
  }

  Future<void> _openEditClinic(BuildContext context, ClinicModel clinic) async {
    final result = await context.pushNamed(
      AppRoutes.addClinic,
      extra: clinic,
    );
    if (result == true && context.mounted) {
      context.read<ProfileBloc>().add(const LoadProfileEvent());
    }
  }

  Future<void> _confirmDelete(BuildContext context, ClinicModel clinic) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => ClinicDeleteConfirmDialog(clinicName: clinic.name),
    );

    if (confirmed == true && context.mounted) {
      context.read<ProfileBloc>().add(DeleteClinicEvent(clinic.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.domain_add_outlined,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.clinicsManagement,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      strings.addAllClinicsWhereYouPractice,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _openAddClinic(context),
                icon: const Icon(Icons.add, size: 16),
                label: Text(strings.addClinic),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          if (profile.clinics.isNotEmpty) ...[
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profile.clinics.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final clinic = profile.clinics[index];
                return ClinicListItemCard(
                  index: index,
                  clinic: clinic,
                  onEdit: () => _openEditClinic(context, clinic),
                  onDelete: () => _confirmDelete(context, clinic),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
