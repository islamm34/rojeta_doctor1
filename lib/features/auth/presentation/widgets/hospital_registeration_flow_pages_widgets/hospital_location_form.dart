import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class HospitalLocationForm extends StatelessWidget {
  const HospitalLocationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
          // Header row with icon and "Choose on map" action
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
              GestureDetector(
                onTap: () {
                  // ponytail: open map picker; integrate map_picker package when available.
                },
                child: Text(
                  context.strings.chooseOnMap,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Governorate *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.governorate != c.governorate,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.governorate,
                hintText: '',
                isRequired: true,
                onChanged: (val) =>
                    context.read<AuthBloc>().add(GovernorateChangedEvent(val)),
              );
            },
          ),

          SizedBox(height: 16.h),

          // City *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.city != c.city,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.city,
                hintText: 'nasr',
                isRequired: true,
                onChanged: (val) =>
                    context.read<AuthBloc>().add(CityChangedEvent(val)),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Full Address *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.fullAddress != c.fullAddress,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.fullAddress,
                hintText: context.strings.fullAddressHint,
                isRequired: true,
                minLines: 2,
                maxLines: 3,
                onChanged: (val) =>
                    context.read<AuthBloc>().add(FullAddressChangedEvent(val)),
              );
            },
          ),
        ],
      ),
    );
  }
}
