import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/shared/models/time_slot_model.dart';

export 'package:rojeta_doctor/shared/models/time_slot_model.dart';

class WorkingDayModel extends Equatable {
  final String dayName;
  final bool isActive;
  final List<TimeSlotModel> timeSlots;

  const WorkingDayModel({
    required this.dayName,
    required this.isActive,
    required this.timeSlots,
  });

  String get day => dayName;
  List<TimeSlotModel> get slots => timeSlots;

  factory WorkingDayModel.fromJson(Map<String, dynamic> json) {
    return WorkingDayModel(
      dayName: json['day_name'],
      isActive: json['is_active'],
      timeSlots: (json['time_slots'] as List)
          .map((slot) => TimeSlotModel.fromJson(slot))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day_name': dayName,
      'is_active': isActive,
      'time_slots': timeSlots.map((slot) => slot.toJson()).toList(),
    };
  }

  WorkingDayModel copyWith({
    String? dayName,
    bool? isActive,
    List<TimeSlotModel>? timeSlots,
  }) {
    return WorkingDayModel(
      dayName: dayName ?? this.dayName,
      isActive: isActive ?? this.isActive,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }

  @override
  List<Object?> get props => [dayName, isActive, timeSlots];
}

class VacationModel extends Equatable {
  final String id;
  final String startDate;
  final String endDate;

  const VacationModel({
    required this.id,
    required this.startDate,
    required this.endDate,
  });

  factory VacationModel.fromJson(Map<String, dynamic> json) {
    return VacationModel(
      id: json['id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  @override
  List<Object?> get props => [id, startDate, endDate];
}

class ScheduleModel extends Equatable {
  final List<WorkingDayModel> workingDays;
  final List<VacationModel> vacations;

  const ScheduleModel({
    required this.workingDays,
    required this.vacations,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      workingDays: (json['working_days'] as List)
          .map((day) => WorkingDayModel.fromJson(day))
          .toList(),
      vacations: (json['vacations'] as List)
          .map((vac) => VacationModel.fromJson(vac))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'working_days': workingDays.map((day) => day.toJson()).toList(),
      'vacations': vacations.map((vac) => vac.toJson()).toList(),
    };
  }

  ScheduleModel copyWith({
    List<WorkingDayModel>? workingDays,
    List<VacationModel>? vacations,
  }) {
    return ScheduleModel(
      workingDays: workingDays ?? this.workingDays,
      vacations: vacations ?? this.vacations,
    );
  }

  @override
  List<Object?> get props => [workingDays, vacations];
}
