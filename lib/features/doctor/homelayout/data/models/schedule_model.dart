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
    final rawSlots = json['time_slots'] ?? json['timeSlots'] ?? json['slots'];
    final List<TimeSlotModel> parsedSlots = [];
    if (rawSlots is List) {
      for (final s in rawSlots) {
        if (s is Map<String, dynamic>) {
          parsedSlots.add(TimeSlotModel.fromJson(s));
        }
      }
    }

    return WorkingDayModel(
      dayName: (json['day_name'] ?? json['day'] ?? json['name'] ?? '').toString(),
      isActive: (json['is_active'] ?? json['isActive'] ?? (parsedSlots.isNotEmpty)) as bool? ?? false,
      timeSlots: parsedSlots,
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
      id: (json['id'] ?? '').toString(),
      startDate: (json['start_date'] ?? json['startDate'] ?? '').toString(),
      endDate: (json['end_date'] ?? json['endDate'] ?? '').toString(),
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

  static List<WorkingDayModel> defaultWorkingDays() => [
        const WorkingDayModel(
          dayName: 'Saturday',
          isActive: true,
          timeSlots: [
            TimeSlotModel(startTime: '09:00', endTime: '17:00'),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Sunday',
          isActive: true,
          timeSlots: [
            TimeSlotModel(startTime: '09:00', endTime: '17:00'),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Monday',
          isActive: true,
          timeSlots: [
            TimeSlotModel(startTime: '09:00', endTime: '17:00'),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Tuesday',
          isActive: true,
          timeSlots: [
            TimeSlotModel(startTime: '09:00', endTime: '17:00'),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Wednesday',
          isActive: true,
          timeSlots: [
            TimeSlotModel(startTime: '09:00', endTime: '17:00'),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Thursday',
          isActive: true,
          timeSlots: [
            TimeSlotModel(startTime: '09:00', endTime: '17:00'),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Friday',
          isActive: false,
          timeSlots: [],
        ),
      ];

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    final rawDays = json['working_days'] ??
        json['workingDays'] ??
        json['schedule'] ??
        json['days'];
    List<WorkingDayModel> parsedDays = [];
    if (rawDays is List) {
      for (final d in rawDays) {
        if (d is Map<String, dynamic>) {
          parsedDays.add(WorkingDayModel.fromJson(d));
        }
      }
    }
    if (parsedDays.isEmpty) {
      parsedDays = defaultWorkingDays();
    }

    final rawVacations = json['vacations'] ?? json['leaves'] ?? [];
    List<VacationModel> parsedVacations = [];
    if (rawVacations is List) {
      for (final v in rawVacations) {
        if (v is Map<String, dynamic>) {
          parsedVacations.add(VacationModel.fromJson(v));
        }
      }
    }

    return ScheduleModel(
      workingDays: parsedDays,
      vacations: parsedVacations,
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
