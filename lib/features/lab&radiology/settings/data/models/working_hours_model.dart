import 'package:equatable/equatable.dart';

class WorkingHoursModel extends Equatable {
  final List<DayScheduleModel>? standardWeek;
  final List<SpecialDateModel>? upcomingOverrides;

  const WorkingHoursModel({
    this.standardWeek = const [],
    this.upcomingOverrides = const [],
  });

  factory WorkingHoursModel.fromJson(Map<String, dynamic> json) {
    final rawWeek = json['standardWeek'] ?? json['standard_week'] ?? json['days'] ?? json['schedule'];
    final rawOverrides = json['upcomingOverrides'] ?? json['upcoming_overrides'] ?? json['special_dates'] ?? json['overrides'];

    return WorkingHoursModel(
      standardWeek: (rawWeek is List)
          ? rawWeek
              .whereType<Map<String, dynamic>>()
              .map((e) => DayScheduleModel.fromJson(e))
              .toList()
          : const [],
      upcomingOverrides: (rawOverrides is List)
          ? rawOverrides
              .whereType<Map<String, dynamic>>()
              .map((e) => SpecialDateModel.fromJson(e))
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'standard_week': standardWeek?.map((e) => e.toJson()).toList(),
      'upcoming_overrides': upcomingOverrides?.map((e) => e.toJson()).toList(),
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
  final String? dayName;
  final bool? isClosed;
  final String? openingTime;
  final String? closingTime;

  const DayScheduleModel({
    this.dayName,
    this.isClosed = false,
    this.openingTime,
    this.closingTime,
  });

  factory DayScheduleModel.fromJson(Map<String, dynamic> json) {
    return DayScheduleModel(
      dayName: (json['dayName'] ?? json['day_name'] ?? json['day']) as String?,
      isClosed: json['isClosed'] as bool? ?? json['is_closed'] as bool? ?? false,
      openingTime: (json['openingTime'] ?? json['opening_time'] ?? json['from'] ?? json['start_time']) as String?,
      closingTime: (json['closingTime'] ?? json['closing_time'] ?? json['to'] ?? json['end_time']) as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day_name': dayName,
      'is_closed': isClosed,
      'opening_time': openingTime,
      'closing_time': closingTime,
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
  final String? id;
  final String? dateStr;
  final String? eventName;
  final bool? isClosed;
  final String? openingTime;
  final String? closingTime;

  const SpecialDateModel({
    this.id,
    this.dateStr,
    this.eventName,
    this.isClosed = false,
    this.openingTime,
    this.closingTime,
  });

  factory SpecialDateModel.fromJson(Map<String, dynamic> json) {
    return SpecialDateModel(
      id: (json['id'] ?? json['_id'])?.toString(),
      dateStr: (json['dateStr'] ?? json['date_str'] ?? json['date']) as String?,
      eventName: (json['eventName'] ?? json['event_name'] ?? json['name'] ?? json['title']) as String?,
      isClosed: json['isClosed'] as bool? ?? json['is_closed'] as bool? ?? false,
      openingTime: (json['openingTime'] ?? json['opening_time'] ?? json['from']) as String?,
      closingTime: (json['closingTime'] ?? json['closing_time'] ?? json['to']) as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_str': dateStr,
      'event_name': eventName,
      'is_closed': isClosed,
      'opening_time': openingTime,
      'closing_time': closingTime,
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
