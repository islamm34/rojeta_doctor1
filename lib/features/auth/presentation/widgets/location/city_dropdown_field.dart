import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../shared/widgets/custom_dropdown_field.dart';
import '../../../data/models/egypt_location.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class CityDropdownField extends StatelessWidget {
  final bool isRequired;

  const CityDropdownField({
    super.key,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.governorate != current.governorate ||
          previous.city != current.city,
      builder: (context, state) {
        final currentGov = EgyptGovernorate.fromString(
          state.governorate,
          context: context,
        );
        final availableCities = currentGov?.cities ?? const [];

        final currentCity = EgyptCity.fromString(
          state.city,
          governorate: currentGov,
          context: context,
        );

        final hintText = currentGov == null
            ? context.strings.selectGovernorateFirst
            : context.strings.selectCity;

        return CustomDropdownField<EgyptCity>(
          key: ValueKey('city_${currentGov?.value}_${currentCity?.value}'),
          label: context.strings.city,
          hintText: hintText,
          isRequired: isRequired,
          enabled: currentGov != null && availableCities.isNotEmpty,
          value: currentCity,
          items: availableCities.map((city) {
            return DropdownMenuItem<EgyptCity>(
              value: city,
              child: Text(
                city.localizedName(context),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (selected) {
            if (selected != null) {
              context.read<AuthBloc>().add(
                    CityChangedEvent(selected.value),
                  );
            } else {
              context.read<AuthBloc>().add(
                    const CityChangedEvent(''),
                  );
            }
          },
        );
      },
    );
  }
}

