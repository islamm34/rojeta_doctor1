import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';

import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../data/models/profile_model.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';

class ServicesPricingSection extends StatelessWidget {
  final ProfileModel profile;

  const ServicesPricingSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.attach_money_outlined,
              color: theme.colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              context.strings.servicesAndPricing,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...profile.services.map(
          (service) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getLocalizedServiceName(context, service.name),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        value: service.isEnabled,
                        onChanged: (val) {
                          context.read<ProfileBloc>().add(
                            ToggleServiceEvent(service.id, val),
                          );
                        },
                        activeThumbColor: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                  if (service.isEnabled) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '${context.strings.price}: ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            initialValue: service.price.toInt().toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              final newPrice = double.tryParse(val);
                              if (newPrice != null) {
                                context.read<ProfileBloc>().add(
                                  UpdateServicePriceEvent(service.id, newPrice),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          context.strings.egp,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getLocalizedServiceName(BuildContext context, String rawName) {
    switch (rawName) {
      case 'Clinic Visit':
        return context.strings.clinicVisit;
      case 'Home Visit':
        return context.strings.homeVisit;
      case 'Video Call':
        return context.strings.videoCall;
      case 'Follow-up':
        return context.strings.followUp;
      default:
        return rawName;
    }
  }
}
