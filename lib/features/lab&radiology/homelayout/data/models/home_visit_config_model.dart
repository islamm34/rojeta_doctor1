import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/shared/models/time_slot_model.dart';

export 'package:rojeta_doctor/shared/models/time_slot_model.dart';

class ServiceAreaModel extends Equatable {
  final String? id;
  final String? name;
  final int? radiusKm;
  final int? techsAvailable;

  const ServiceAreaModel({
    this.id,
    this.name,
    this.radiusKm,
    this.techsAvailable,
  });

  factory ServiceAreaModel.fromJson(Map<String, dynamic> json) {
    return ServiceAreaModel(
      id: (json['id'] ?? json['_id'])?.toString(),
      name: (json['name'] ?? json['area_name'] ?? json['city']) as String?,
      radiusKm: (json['radiusKm'] ?? json['radius_km'] ?? json['radius']) as int?,
      techsAvailable: (json['techsAvailable'] ?? json['techs_available'] ?? json['staff_count']) as int?,
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
  final bool? isServiceVisible;
  final List<ServiceAreaModel>? serviceAreas;
  final double? collectionFee;
  final double? minimumBookingAmount;
  final List<TimeSlotModel>? weekdaySlots;
  final List<TimeSlotModel>? weekendSlots;
  final bool? isWeekdaysTabActive;

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
    final rawAreas = json['serviceAreas'] ?? json['service_areas'] ?? json['areas'];
    final rawWeekdaySlots = json['weekdaySlots'] ?? json['weekday_slots'] ?? json['weekdays'];
    final rawWeekendSlots = json['weekendSlots'] ?? json['weekend_slots'] ?? json['weekends'];

    return HomeVisitConfigModel(
      isServiceVisible:
          json['isServiceVisible'] as bool? ??
          json['is_service_visible'] as bool? ??
          json['is_active'] as bool? ??
          false,
      serviceAreas: (rawAreas is List)
          ? rawAreas
              .whereType<Map<String, dynamic>>()
              .map((e) => ServiceAreaModel.fromJson(e))
              .toList()
          : const [],
      collectionFee: (json['collectionFee'] ?? json['collection_fee'] ?? json['fee'] as num?)?.toDouble() ?? 0.0,
      minimumBookingAmount:
          (json['minimumBookingAmount'] ?? json['minimum_booking_amount'] ?? json['min_amount'] as num?)?.toDouble() ?? 0.0,
      weekdaySlots: (rawWeekdaySlots is List)
          ? rawWeekdaySlots
              .whereType<Map<String, dynamic>>()
              .map((e) => TimeSlotModel.fromJson(e))
              .toList()
          : const [],
      weekendSlots: (rawWeekendSlots is List)
          ? rawWeekendSlots
              .whereType<Map<String, dynamic>>()
              .map((e) => TimeSlotModel.fromJson(e))
              .toList()
          : const [],
      isWeekdaysTabActive: json['isWeekdaysTabActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_service_visible': isServiceVisible,
      'service_areas': serviceAreas?.map((e) => e.toJson()).toList(),
      'collection_fee': collectionFee,
      'minimum_booking_amount': minimumBookingAmount,
      'weekday_slots': weekdaySlots?.map((e) => e.toJson()).toList(),
      'weekend_slots': weekendSlots?.map((e) => e.toJson()).toList(),
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
