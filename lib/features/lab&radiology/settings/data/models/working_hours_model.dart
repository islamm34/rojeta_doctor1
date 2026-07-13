import 'package:equatable/equatable.dart';

class WorkingHoursModel extends Equatable {
  final List<DayScheduleModel> standardWeek;
  final List<SpecialDateModel> upcomingOverrides;

  const WorkingHoursModel({
    required this.standardWeek,
    required this.upcomingOverrides,
  });

  factory WorkingHoursModel.fromJson(Map<String, dynamic> json) {
    return WorkingHoursModel(
      standardWeek: (json['standardWeek'] as List<dynamic>?)
              ?.map((e) => DayScheduleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      upcomingOverrides: (json['upcomingOverrides'] as List<dynamic>?)
              ?.map((e) => SpecialDateModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'standardWeek': standardWeek.map((e) => e.toJson()).toList(),
      'upcomingOverrides': upcomingOverrides.map((e) => e.toJson()).toList(),
    };
  }

  WorkingHoursModel copyWith({
    List<DayScheduleModel>? standardWeek,
    List<SpecialDateModel>? upcomingOverrides,
  }) {
    return WorkingHoursModel(
      standardWeek: standardWeek ?? this.standardWeek,
      upcomingOverrides: upcomingOverrides ?? this.upcomingOverrides,
    );
  }

  @override
  List<Object?> get props => [standardWeek, upcomingOverrides];
}

class DayScheduleModel extends Equatable {
  final String dayName;
  final bool isClosed;
  final String openingTime;
  final String closingTime;

  const DayScheduleModel({
    required this.dayName,
    this.isClosed = false,
    required this.openingTime,
    required this.closingTime,
  });

  factory DayScheduleModel.fromJson(Map<String, dynamic> json) {
    return DayScheduleModel(
      dayName: json['dayName'] ?? '',
      isClosed: json['isClosed'] ?? false,
      openingTime: json['openingTime'] ?? '',
      closingTime: json['closingTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayName': dayName,
      'isClosed': isClosed,
      'openingTime': openingTime,
      'closingTime': closingTime,
    };
  }

  DayScheduleModel copyWith({
    String? dayName,
    bool? isClosed,
    String? openingTime,
    String? closingTime,
  }) {
    return DayScheduleModel(
      dayName: dayName ?? this.dayName,
      isClosed: isClosed ?? this.isClosed,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
    );
  }

  @override
  List<Object?> get props => [dayName, isClosed, openingTime, closingTime];
}

class SpecialDateModel extends Equatable {
  final String id;
  final String dateStr;
  final String eventName;
  final bool isClosed;
  final String? openingTime;
  final String? closingTime;

  const SpecialDateModel({
    required this.id,
    required this.dateStr,
    required this.eventName,
    this.isClosed = false,
    this.openingTime,
    this.closingTime,
  });

  factory SpecialDateModel.fromJson(Map<String, dynamic> json) {
    return SpecialDateModel(
      id: json['id'] ?? '',
      dateStr: json['dateStr'] ?? '',
      eventName: json['eventName'] ?? '',
      isClosed: json['isClosed'] ?? false,
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateStr': dateStr,
      'eventName': eventName,
      'isClosed': isClosed,
      'openingTime': openingTime,
      'closingTime': closingTime,
    };
  }
  
  SpecialDateModel copyWith({
    String? id,
    String? dateStr,
    String? eventName,
    bool? isClosed,
    String? openingTime,
    String? closingTime,
  }) {
    return SpecialDateModel(
      id: id ?? this.id,
      dateStr: dateStr ?? this.dateStr,
      eventName: eventName ?? this.eventName,
      isClosed: isClosed ?? this.isClosed,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
    );
  }

  @override
  List<Object?> get props => [id, dateStr, eventName, isClosed, openingTime, closingTime];
}
