import 'package:equatable/equatable.dart';
import '../../../data/models/schedule_model.dart';

enum ScheduleStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  final ScheduleStatus status;
  final ScheduleModel? schedule;
  final String? errorMessage;

  const ScheduleState({
    this.status = ScheduleStatus.initial,
    this.schedule,
    this.errorMessage,
  });

  ScheduleState copyWith({
    ScheduleStatus? status,
    ScheduleModel? schedule,
    String? errorMessage,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      schedule: schedule ?? this.schedule,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, schedule, errorMessage];
}
