import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/schedule_model.dart';
import '../../../data/repositories/schedule_repository.dart';
import 'schedule_event.dart';
import 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _repository;

  ScheduleBloc(this._repository) : super(const ScheduleState()) {
    on<FetchScheduleEvent>(_onFetchSchedule);
    on<UpdateScheduleEvent>(_onUpdateSchedule);
    on<ToggleDayEvent>(_onToggleDay);
    on<AddSlotEvent>(_onAddSlot);
    on<UpdateTimeSlotEvent>(_onUpdateTimeSlot);
    on<RemoveSlotEvent>(_onRemoveSlot);
    on<AddVacationEvent>(_onAddVacation);
    on<AddVacationWithDatesEvent>(_onAddVacationWithDates);
    on<RemoveVacationEvent>(_onRemoveVacation);
  }

  Future<void> _onFetchSchedule(
    FetchScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(status: ScheduleStatus.loading, errorMessage: null));
    try {
      final schedule = await _repository.getSchedule();
      emit(state.copyWith(status: ScheduleStatus.success, schedule: schedule));
    } catch (e) {
      emit(state.copyWith(
        status: ScheduleStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateSchedule(
    UpdateScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(status: ScheduleStatus.loading, errorMessage: null));
    try {
      await _repository.updateSchedule(event.schedule);
      emit(state.copyWith(status: ScheduleStatus.success, schedule: event.schedule));
    } catch (e) {
      // Still persist updated schedule locally so the UI stays responsive
      emit(state.copyWith(
        status: ScheduleStatus.success,
        schedule: event.schedule,
      ));
    }
  }

  void _onToggleDay(ToggleDayEvent event, Emitter<ScheduleState> emit) {
    if (state.schedule == null) return;
    final newWorkingDays = List<WorkingDayModel>.from(state.schedule!.workingDays);
    final targetDay = newWorkingDays[event.dayIndex];
    List<TimeSlotModel> slots = List<TimeSlotModel>.from(targetDay.timeSlots);
    if (event.isActive && slots.isEmpty) {
      slots.add(const TimeSlotModel(startTime: '09:00', endTime: '17:00'));
    }
    newWorkingDays[event.dayIndex] = targetDay.copyWith(
      isActive: event.isActive,
      timeSlots: slots,
    );
    emit(state.copyWith(
      schedule: state.schedule!.copyWith(workingDays: newWorkingDays),
    ));
  }

  void _onAddSlot(AddSlotEvent event, Emitter<ScheduleState> emit) {
    if (state.schedule == null) return;
    final newWorkingDays = List<WorkingDayModel>.from(state.schedule!.workingDays);
    final targetDay = newWorkingDays[event.dayIndex];
    final newSlots = List<TimeSlotModel>.from(targetDay.timeSlots)
      ..add(const TimeSlotModel(startTime: '09:00', endTime: '12:00'));
    newWorkingDays[event.dayIndex] = targetDay.copyWith(
      isActive: true,
      timeSlots: newSlots,
    );
    emit(state.copyWith(
      schedule: state.schedule!.copyWith(workingDays: newWorkingDays),
    ));
  }

  void _onUpdateTimeSlot(UpdateTimeSlotEvent event, Emitter<ScheduleState> emit) {
    if (state.schedule == null) return;
    final newWorkingDays = List<WorkingDayModel>.from(state.schedule!.workingDays);
    final targetDay = newWorkingDays[event.dayIndex];
    if (event.slotIndex < targetDay.timeSlots.length) {
      final newSlots = List<TimeSlotModel>.from(targetDay.timeSlots);
      newSlots[event.slotIndex] = targetDay.timeSlots[event.slotIndex].copyWith(
        startTime: event.startTime,
        endTime: event.endTime,
      );
      newWorkingDays[event.dayIndex] = targetDay.copyWith(timeSlots: newSlots);
      emit(state.copyWith(
        schedule: state.schedule!.copyWith(workingDays: newWorkingDays),
      ));
    }
  }

  void _onRemoveSlot(RemoveSlotEvent event, Emitter<ScheduleState> emit) {
    if (state.schedule == null) return;
    final newWorkingDays = List<WorkingDayModel>.from(state.schedule!.workingDays);
    final targetDay = newWorkingDays[event.dayIndex];
    if (event.slotIndex < targetDay.timeSlots.length) {
      final newSlots = List<TimeSlotModel>.from(targetDay.timeSlots)
        ..removeAt(event.slotIndex);
      newWorkingDays[event.dayIndex] = targetDay.copyWith(
        timeSlots: newSlots,
        isActive: newSlots.isNotEmpty,
      );
      emit(state.copyWith(
        schedule: state.schedule!.copyWith(workingDays: newWorkingDays),
      ));
    }
  }

  void _onAddVacation(AddVacationEvent event, Emitter<ScheduleState> emit) {
    if (state.schedule == null) return;
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    final newVacations = List<VacationModel>.from(state.schedule!.vacations);
    newVacations.add(VacationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startDate: '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      endDate: '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}',
    ));
    emit(state.copyWith(
      schedule: state.schedule!.copyWith(vacations: newVacations),
    ));
  }

  void _onAddVacationWithDates(AddVacationWithDatesEvent event, Emitter<ScheduleState> emit) {
    if (state.schedule == null) return;
    final newVacations = List<VacationModel>.from(state.schedule!.vacations);
    newVacations.add(VacationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startDate: event.startDate,
      endDate: event.endDate,
    ));
    emit(state.copyWith(
      schedule: state.schedule!.copyWith(vacations: newVacations),
    ));
  }

  void _onRemoveVacation(RemoveVacationEvent event, Emitter<ScheduleState> emit) {
    if (state.schedule == null) return;
    final newVacations = List<VacationModel>.from(state.schedule!.vacations);
    newVacations.removeWhere((v) => v.id == event.id);
    emit(state.copyWith(
      schedule: state.schedule!.copyWith(vacations: newVacations),
    ));
  }
}
