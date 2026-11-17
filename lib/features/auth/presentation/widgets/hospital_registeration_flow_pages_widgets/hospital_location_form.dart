import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../location/city_dropdown_field.dart';
import '../location/governorate_dropdown_field.dart';
import '../location/map_location_picker_button.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class HospitalLocationForm extends StatefulWidget {
  const HospitalLocationForm({super.key});

  @override
  State<HospitalLocationForm> createState() => _HospitalLocationFormState();
}

class _HospitalLocationFormState extends State<HospitalLocationForm> {
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(
      text: context.read<AuthBloc>().state.fullAddress,
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.fullAddress != current.fullAddress,
      listener: (context, state) {
        if (_addressController.text != state.fullAddress) {
          _addressController.text = state.fullAddress;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      context.strings.location,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Governorate *
            const GovernorateDropdownField(isRequired: true),

            SizedBox(height: 16.h),

            // City *
            const CityDropdownField(isRequired: true),

            SizedBox(height: 16.h),

            // Full Address *
            CustomTextField(
              label: context.strings.fullAddress,
              hintText: context.strings.fullAddressHint,
              controller: _addressController,
              minLines: 2,
              maxLines: 3,
              onChanged: (val) =>
                  context.read<AuthBloc>().add(FullAddressChangedEvent(val)),
            ),

            SizedBox(height: 16.h),

            // + Location (Choose on Map)
            MapLocationPickerButton(
              onLocationChanged: (loc) {
                if (loc.address?.isNotEmpty == true) {
                  _addressController.text = loc.address!;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
