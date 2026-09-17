import 'package:equatable/equatable.dart';

import 'lab_service_model.dart';

class LabServicesResponseModel extends Equatable {
  final List<LabServiceModel>? services;
  final int? totalActiveServices;
  final int? homeVisitsAvailableCount;

  const LabServicesResponseModel({
    this.services,
    this.totalActiveServices,
    this.homeVisitsAvailableCount,
  });

  factory LabServicesResponseModel.fromJson(Map<String, dynamic> json) {
    List<LabServiceModel> parsedServices = [];

    final rawList =
        json['services'] ?? json['tests'] ?? json['data'] ?? json['items'];
    if (rawList is List) {
      parsedServices = rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => LabServiceModel.fromJson(e))
          .toList();
    }

    final totalActive =
        (json['total_active'] ??
                json['totalActiveServices'] ??
                json['total_services'] ??
                json['total_active_services'] ??
                json['count'])
            as int? ??
        parsedServices.where((s) => s.isActive ?? true).length;

    final homeVisits =
        (json['home_visits_count'] ??
                json['homeVisitsAvailableCount'] ??
                json['home_collection_count'] ??
                json['home_visits'])
            as int? ??
        parsedServices.where((s) => s.isHomeCollectionAvailable == true).length;

    return LabServicesResponseModel(
      services: parsedServices,
      totalActiveServices: totalActive,
      homeVisitsAvailableCount: homeVisits,
    );
  }

  factory LabServicesResponseModel.fromList(List<dynamic> list) {
    final parsedServices = list
        .whereType<Map<String, dynamic>>()
        .map((e) => LabServiceModel.fromJson(e))
        .toList();

    return LabServicesResponseModel(
      services: parsedServices,
      totalActiveServices: parsedServices
          .where((s) => s.isActive ?? true)
          .length,
      homeVisitsAvailableCount: parsedServices
          .where((s) => s.isHomeCollectionAvailable == true)
          .length,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'services': services?.map((e) => e.toJson()).toList(),
      'total_active_services': totalActiveServices,
      'home_visits_available_count': homeVisitsAvailableCount,
    };
  }

  @override
  List<Object?> get props => [
    services,
    totalActiveServices,
    homeVisitsAvailableCount,
  ];
}
