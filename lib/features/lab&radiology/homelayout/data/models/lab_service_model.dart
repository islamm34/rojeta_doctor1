import 'package:equatable/equatable.dart';

class LabServiceModel extends Equatable {
  final String? id;
  final String? name;
  final double? price;
  final bool? isHomeCollectionAvailable;
  final bool? requiresFasting;
  final String? turnaroundTime; // e.g., "24 hours", "48 hours"
  final String? category; // e.g., "Hematology", "Radiology"
  final String? description;
  final String? instructions;
  final bool? isActive;

  const LabServiceModel({
    this.id,
    this.name,
    this.price,
    this.isHomeCollectionAvailable,
    this.requiresFasting = false,
    this.turnaroundTime,
    this.category,
    this.description,
    this.instructions,
    this.isActive = true,
  });

  factory LabServiceModel.fromJson(Map<String, dynamic> json) {
    return LabServiceModel(
      id: (json['id'] ?? json['_id'])?.toString(),
      name:
          (json['name'] ??
                  json['title'] ??
                  json['service_name'] ??
                  json['test_name'])
              as String?,
      price:
          (json['price'] as num?)?.toDouble() ??
          (json['cost'] as num?)?.toDouble() ??
          (json['fee'] as num?)?.toDouble(),
      isHomeCollectionAvailable:
          json['isHomeCollectionAvailable'] as bool? ??
          json['is_home_collection_available'] as bool? ??
          json['home_visit_available'] as bool? ??
          json['home_collection'] as bool?,
      requiresFasting:
          json['requiresFasting'] as bool? ??
          json['requires_fasting'] as bool? ??
          json['fasting_required'] as bool? ??
          false,
      turnaroundTime:
          (json['turnaroundTime'] ??
                  json['turnaround_time'] ??
                  json['duration'] ??
                  json['delivery_time'])
              as String?,
      category:
          (json['category'] ??
                  json['category_name'] ??
                  json['type'] ??
                  json['department'])
              as String?,
      description: (json['description'] ?? json['details']) as String?,
      instructions: (json['instructions'] ?? json['preparations']) as String?,
      isActive: json['is_active'] as bool? ?? json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isHomeCollectionAvailable': isHomeCollectionAvailable,
      'requiresFasting': requiresFasting,
      'turnaroundTime': turnaroundTime,
      'category': category,
      'description': description,
      'instructions': instructions,
      'is_active': isActive,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    isHomeCollectionAvailable,
    requiresFasting,
    turnaroundTime,
    category,
    description,
    instructions,
    isActive,
  ];
}
