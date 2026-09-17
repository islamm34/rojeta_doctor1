import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_bloc.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_event.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_state.dart';

import 'widgets/day_schedule_tile.dart';
import 'widgets/special_hours_section.dart';

class WorkingHoursPage extends StatefulWidget {
  const WorkingHoursPage({super.key});

  @override
  State<WorkingHoursPage> createState() => _WorkingHoursPageState();
}

class _WorkingHoursPageState extends State<WorkingHoursPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(LoadWorkingHoursEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Working Hours',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state.workingHours == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final workingHours = state.workingHours!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Standard Week',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2D52),
                  ),
                ),
                SizedBox(height: 16.h),
                ...(workingHours.standardWeek ?? []).map(
                  (day) => DayScheduleTile(day: day),
                ),
                SizedBox(height: 32.h),
                const Divider(),
                SizedBox(height: 24.h),
                SpecialHoursSection(
                  overrides: workingHours.upcomingOverrides ?? const [],
                ),
                SizedBox(height: 40.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
