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
    on<AddVacationEvent>(_onAddVacation);
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
      emit(state.copyWith(
        status: ScheduleStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onToggleDay(ToggleDayEvent event, Emitter<ScheduleState> emit) {
    if (state.schedule == null) return;
    final newWorkingDays = List<WorkingDayModel>.from(state.schedule!.workingDays);
    final targetDay = newWorkingDays[event.dayIndex];
    newWorkingDays[event.dayIndex] = targetDay.copyWith(isActive: event.isActive);
    emit(state.copyWith(
      schedule: state.schedule!.copyWith(workingDays: newWorkingDays),
    ));
  }

  void _onAddSlot(AddSlotEvent event, Emitter<ScheduleState> emit) {
    if (state.schedule == null) return;
    final newWorkingDays = List<WorkingDayModel>.from(state.schedule!.workingDays);
    final targetDay = newWorkingDays[event.dayIndex];
    final newSlots = List<TimeSlotModel>.from(targetDay.timeSlots)..add(const TimeSlotModel(startTime: '', endTime: ''));
    newWorkingDays[event.dayIndex] = targetDay.copyWith(timeSlots: newSlots);
    emit(state.copyWith(
      schedule: state.schedule!.copyWith(workingDays: newWorkingDays),
    ));
  }

  void _onAddVacation(AddVacationEvent event, Emitter<ScheduleState> emit) {
    if (state.schedule == null) return;
    final newVacations = List<VacationModel>.from(state.schedule!.vacations);
    newVacations.add(VacationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startDate: 'YYYY-MM-DD',
      endDate: 'YYYY-MM-DD',
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
