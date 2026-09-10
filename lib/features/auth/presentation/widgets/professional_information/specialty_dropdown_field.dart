import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../shared/widgets/custom_dropdown_field.dart';
import '../../../data/models/doctor_specialty.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class SpecialtyDropdownField extends StatelessWidget {
  const SpecialtyDropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.specialty != current.specialty,
      builder: (context, state) {
        final currentSpecialty = DoctorSpecialty.fromString(state.specialty);

        return CustomDropdownField<DoctorSpecialty>(
          label: context.strings.specialty,
          hintText: context.strings.selectSpecialty,
          isRequired: true,
          value: currentSpecialty,
          items: DoctorSpecialty.values.map((specialty) {
            return DropdownMenuItem<DoctorSpecialty>(
              value: specialty,
              child: Text(specialty.localizedName(context)),
            );
          }).toList(),
          onChanged: (selected) {
            if (selected != null) {
              context.read<AuthBloc>().add(
                    SpecialtyChangedEvent(selected.value),
                  );
            }
          },
        );
      },
    );
  }
}
