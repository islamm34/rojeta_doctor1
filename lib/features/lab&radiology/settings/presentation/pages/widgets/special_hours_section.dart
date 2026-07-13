import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/data/models/working_hours_model.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_bloc.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_event.dart';
import 'add_special_date_bottom_sheet.dart';

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
          ...overrides.map((override) => _buildOverrideCard(context, override)),
      ],
    );
  }

  Widget _buildOverrideCard(BuildContext context, SpecialDateModel override) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  override.dateStr,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2D52),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    override.eventName,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2D52),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  if (override.isClosed)
                    Text(
                      'Closed',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: const Color(0xFFEF4444),
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  else
                    Text(
                      '${override.openingTime} - ${override.closingTime}',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              context.read<SettingsBloc>().add(RemoveSpecialDateEvent(override.id));
            },
            icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
          ),
        ],
      ),
    );
  }
}
