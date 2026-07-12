import 'package:equatable/equatable.dart';
import '../../../data/models/schedule_model.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

class FetchScheduleEvent extends ScheduleEvent {}

class UpdateScheduleEvent extends ScheduleEvent {
  final ScheduleModel schedule;

  const UpdateScheduleEvent(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class ToggleDayEvent extends ScheduleEvent {
  final int dayIndex;
  final bool isActive;

  const ToggleDayEvent(this.dayIndex, this.isActive);

  @override
  List<Object?> get props => [dayIndex, isActive];
}

class AddSlotEvent extends ScheduleEvent {
  final int dayIndex;

  const AddSlotEvent(this.dayIndex);

  @override
  List<Object?> get props => [dayIndex];
}

class RemoveVacationEvent extends ScheduleEvent {
  final String id;

  const RemoveVacationEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddVacationEvent extends ScheduleEvent {}
