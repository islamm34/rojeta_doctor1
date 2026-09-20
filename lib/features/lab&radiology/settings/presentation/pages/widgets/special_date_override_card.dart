import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/working_hours_model.dart';
import '../../bloc/settings_bloc.dart';
import '../../bloc/settings_event.dart';

class SpecialDateOverrideCard extends StatelessWidget {
  final SpecialDateModel specialDate;

  const SpecialDateOverrideCard({super.key, required this.specialDate});

  @override
  Widget build(BuildContext context) {
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
                  specialDate.dateStr ?? '',
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
                    specialDate.eventName ?? '',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2D52),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  if (specialDate.isClosed == true)
                    Text(
                      context.strings.closed,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: const Color(0xFFEF4444),
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  else
                    Text(
                      '${specialDate.openingTime ?? ''} - ${specialDate.closingTime ?? ''}',
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
              if (specialDate.id != null) {
                context.read<SettingsBloc>().add(
                  RemoveSpecialDateEvent(specialDate.id!),
                );
              }
            },
            icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
          ),
        ],
      ),
    );
  }
}
