import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../bloc/schedule/schedule_bloc.dart';
import '../bloc/schedule/schedule_event.dart';
import '../bloc/schedule/schedule_state.dart';
import '../widgets/schedule/vacations_section.dart';
import '../widgets/schedule/working_hours_section.dart';

class ScheduleManagementPage extends StatelessWidget {
  const ScheduleManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.strings.scheduleManagement,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: BlocConsumer<ScheduleBloc, ScheduleState>(
        listener: (context, state) {
          if (state.status == ScheduleStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.strings.scheduleSavedSuccessfully),
                backgroundColor: Colors.green.shade700,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == ScheduleStatus.loading ||
              state.status == ScheduleStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ScheduleStatus.failure) {
            return Center(
              child: Text(
                state.errorMessage ?? context.strings.errorOccurred,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final schedule = state.schedule;
          if (schedule == null) {
            return Center(child: Text(context.strings.noDataFound));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WorkingHoursSection(
                  workingDays: schedule.workingDays,
                  onToggleDay: (index, isActive) {
                    context.read<ScheduleBloc>().add(
                      ToggleDayEvent(index, isActive),
                    );
                  },
                  onAddSlot: (index) {
                    context.read<ScheduleBloc>().add(AddSlotEvent(index));
                  },
                  onUpdateSlot: (dayIndex, slotIndex, startTime, endTime) {
                    context.read<ScheduleBloc>().add(
                      UpdateTimeSlotEvent(
                        dayIndex: dayIndex,
                        slotIndex: slotIndex,
                        startTime: startTime,
                        endTime: endTime,
                      ),
                    );
                  },
                  onRemoveSlot: (dayIndex, slotIndex) {
                    context.read<ScheduleBloc>().add(
                      RemoveSlotEvent(dayIndex: dayIndex, slotIndex: slotIndex),
                    );
                  },
                  onSave: () {
                    context.read<ScheduleBloc>().add(
                      UpdateScheduleEvent(schedule),
                    );
                    context.pop();
                  },
                ),
                SizedBox(height: 24.h),
                VacationsSection(
                  vacations: schedule.vacations,
                  onAddVacationWithDates: (startDate, endDate) {
                    context.read<ScheduleBloc>().add(
                      AddVacationWithDatesEvent(
                        startDate: startDate,
                        endDate: endDate,
                      ),
                    );
                  },
                  onAddVacation: () {
                    context.read<ScheduleBloc>().add(AddVacationEvent());
                  },
                  onRemoveVacation: (id) {
                    context.read<ScheduleBloc>().add(RemoveVacationEvent(id));
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
