import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/shared/models/time_slot_model.dart';

export 'package:rojeta_doctor/shared/models/time_slot_model.dart';

class ServiceAreaModel extends Equatable {
  final String id;
  final String name;
  final int radiusKm;
  final int techsAvailable;

  const ServiceAreaModel({
    required this.id,
    required this.name,
    required this.radiusKm,
    required this.techsAvailable,
  });

  factory ServiceAreaModel.fromJson(Map<String, dynamic> json) {
    return ServiceAreaModel(
      id: json['id'] as String,
      name: json['name'] as String,
      radiusKm: json['radiusKm'] as int,
      techsAvailable: json['techsAvailable'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'radiusKm': radiusKm,
      'techsAvailable': techsAvailable,
    };
  }

  @override
  List<Object?> get props => [id, name, radiusKm, techsAvailable];
}


class HomeVisitConfigModel extends Equatable {
  final bool isServiceVisible;
  final List<ServiceAreaModel> serviceAreas;
  final double collectionFee;
  final double minimumBookingAmount;
  final List<TimeSlotModel> weekdaySlots;
  final List<TimeSlotModel> weekendSlots;
  final bool isWeekdaysTabActive;

  const HomeVisitConfigModel({
    this.isServiceVisible = false,
    this.serviceAreas = const [],
    this.collectionFee = 0.0,
    this.minimumBookingAmount = 0.0,
    this.weekdaySlots = const [],
    this.weekendSlots = const [],
    this.isWeekdaysTabActive = true,
  });

  factory HomeVisitConfigModel.fromJson(Map<String, dynamic> json) {
    return HomeVisitConfigModel(
      isServiceVisible: json['isServiceVisible'] as bool? ?? false,
      serviceAreas:
          (json['serviceAreas'] as List<dynamic>?)
              ?.map((e) => ServiceAreaModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      collectionFee: (json['collectionFee'] as num?)?.toDouble() ?? 0.0,
      minimumBookingAmount:
          (json['minimumBookingAmount'] as num?)?.toDouble() ?? 0.0,
      weekdaySlots:
          (json['weekdaySlots'] as List<dynamic>?)
              ?.map((e) => TimeSlotModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      weekendSlots:
          (json['weekendSlots'] as List<dynamic>?)
              ?.map((e) => TimeSlotModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isServiceVisible': isServiceVisible,
      'serviceAreas': serviceAreas.map((e) => e.toJson()).toList(),
      'collectionFee': collectionFee,
      'minimumBookingAmount': minimumBookingAmount,
      'weekdaySlots': weekdaySlots.map((e) => e.toJson()).toList(),
      'weekendSlots': weekendSlots.map((e) => e.toJson()).toList(),
    };
  }

  HomeVisitConfigModel copyWith({
    bool? isServiceVisible,
    List<ServiceAreaModel>? serviceAreas,
    double? collectionFee,
    double? minimumBookingAmount,
    List<TimeSlotModel>? weekdaySlots,
    List<TimeSlotModel>? weekendSlots,
    bool? isWeekdaysTabActive,
  }) {
    return HomeVisitConfigModel(
      isServiceVisible: isServiceVisible ?? this.isServiceVisible,
      serviceAreas: serviceAreas ?? this.serviceAreas,
      collectionFee: collectionFee ?? this.collectionFee,
      minimumBookingAmount: minimumBookingAmount ?? this.minimumBookingAmount,
      weekdaySlots: weekdaySlots ?? this.weekdaySlots,
      weekendSlots: weekendSlots ?? this.weekendSlots,
      isWeekdaysTabActive: isWeekdaysTabActive ?? this.isWeekdaysTabActive,
    );
  }

  @override
  List<Object?> get props => [
    isServiceVisible,
    serviceAreas,
    collectionFee,
    minimumBookingAmount,
    weekdaySlots,
    weekendSlots,
    isWeekdaysTabActive,
  ];
}
