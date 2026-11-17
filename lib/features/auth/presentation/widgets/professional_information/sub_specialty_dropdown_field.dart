import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../shared/widgets/custom_dropdown_field.dart';
import '../../../data/models/doctor_specialty.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class SubSpecialtyDropdownField extends StatelessWidget {
  const SubSpecialtyDropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.specialty != current.specialty ||
          previous.subSpecialty != current.subSpecialty,
      builder: (context, state) {
        final currentSpecialty = DoctorSpecialty.fromString(state.specialty);
        final availableSubSpecialties =
            currentSpecialty?.subSpecialties ?? const [];

        final currentSubSpecialty = DoctorSubSpecialty.fromString(
          state.subSpecialty,
          specialty: currentSpecialty,
          context: context,
        );

        final hintText = currentSpecialty == null
            ? context.strings.selectPrimarySpecialtyFirst
            : context.strings.selectSubSpecialty;

        return CustomDropdownField<DoctorSubSpecialty>(
          key: ValueKey(
            'sub_specialty_${currentSpecialty?.value}_${currentSubSpecialty?.value}',
          ),
          label: context.strings.subSpecialty,
          hintText: hintText,
          isRequired: false,
          enabled:
              currentSpecialty != null && availableSubSpecialties.isNotEmpty,
          value: currentSubSpecialty,
          items: availableSubSpecialties.map((sub) {
            return DropdownMenuItem<DoctorSubSpecialty>(
              value: sub,
              child: Text(
                sub.localizedName(context),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (selected) {
            if (selected != null) {
              context.read<AuthBloc>().add(
                    SubSpecialtyChangedEvent(selected.value),
                  );
            } else {
              context.read<AuthBloc>().add(
                    const SubSpecialtyChangedEvent(''),
                  );
            }
          },
        );
      },
    );
  }
}
