import 'package:equatable/equatable.dart';

enum TimeSlotStatus { active, ready, disabled }

class TimeSlotModel extends Equatable {
  final String id;
  final String startTime;
  final String endTime;
  final String time;
  final String amPm;
  final TimeSlotStatus status;

  const TimeSlotModel({
    this.id = '',
    String? startTime,
    String? endTime,
    String? time,
    String? amPm,
    this.status = TimeSlotStatus.active,
  })  : startTime = startTime ?? time ?? '',
        endTime = endTime ?? '',
        time = time ?? startTime ?? '',
        amPm = amPm ?? '';

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    final rawStartTime =
        (json['start_time'] ?? json['startTime'] ?? json['time']) as String? ??
            '';
    final rawEndTime =
        (json['end_time'] ?? json['endTime']) as String? ?? '';
    final rawTime = (json['time'] ?? rawStartTime) as String? ?? '';
    final rawAmPm =
        (json['amPm'] ?? json['am_pm']) as String? ?? '';

    TimeSlotStatus resolvedStatus = TimeSlotStatus.active;
    if (json['status'] != null) {
      resolvedStatus = TimeSlotStatus.values.firstWhere(
        (e) =>
            e.name == json['status'] ||
            e.toString().split('.').last == json['status'],
        orElse: () => TimeSlotStatus.disabled,
      );
    }

    return TimeSlotModel(
      id: json['id'] as String? ?? '',
      startTime: rawStartTime,
      endTime: rawEndTime,
      time: rawTime,
      amPm: rawAmPm,
      status: resolvedStatus,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      if (startTime.isNotEmpty) 'start_time': startTime,
      if (endTime.isNotEmpty) 'end_time': endTime,
      if (time.isNotEmpty) 'time': time,
      if (amPm.isNotEmpty) 'amPm': amPm,
      'status': status.name,
    };
  }

  TimeSlotModel copyWith({
    String? id,
    String? startTime,
    String? endTime,
    String? time,
    String? amPm,
    TimeSlotStatus? status,
  }) {
    return TimeSlotModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      time: time ?? this.time,
      amPm: amPm ?? this.amPm,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, startTime, endTime, time, amPm, status];
}
