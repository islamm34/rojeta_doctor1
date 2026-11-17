import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../shared/widgets/custom_dropdown_field.dart';
import '../../../data/models/egypt_location.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class GovernorateDropdownField extends StatelessWidget {
  final bool isRequired;

  const GovernorateDropdownField({
    super.key,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.governorate != current.governorate,
      builder: (context, state) {
        final currentGov = EgyptGovernorate.fromString(
          state.governorate,
          context: context,
        );

        return CustomDropdownField<EgyptGovernorate>(
          key: ValueKey('gov_${currentGov?.value}'),
          label: context.strings.governorate,
          hintText: context.strings.selectGovernorate,
          isRequired: isRequired,
          value: currentGov,
          items: EgyptGovernorate.values.map((gov) {
            return DropdownMenuItem<EgyptGovernorate>(
              value: gov,
              child: Text(
                gov.localizedName(context),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (selected) {
            if (selected != null) {
              context.read<AuthBloc>().add(
                    GovernorateChangedEvent(selected.value),
                  );
            } else {
              context.read<AuthBloc>().add(
                    const GovernorateChangedEvent(''),
                  );
            }
          },
        );
      },
    );
  }
}

