import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/working_hours_model.dart';
import '../../bloc/settings_bloc.dart';
import 'add_special_date_bottom_sheet.dart';
import 'special_date_override_card.dart';

class SpecialHoursSection extends StatelessWidget {
  final List<SpecialDateModel> overrides;

  const SpecialHoursSection({super.key, required this.overrides});

  void _showAddSpecialDateSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return BlocProvider.value(
          value: context.read<SettingsBloc>(),
          child: const AddSpecialDateBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upcoming Date Overrides',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2D52),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Set special hours or closures for specific dates.',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () => _showAddSpecialDateSheet(context),
              icon: const Icon(Icons.add_circle, color: Color(0xFF0F766E)),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        if (overrides.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                'No upcoming overrides set',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
          )
        else
          ...overrides.map(
            (item) => SpecialDateOverrideCard(specialDate: item),
          ),
      ],
    );
  }
}
