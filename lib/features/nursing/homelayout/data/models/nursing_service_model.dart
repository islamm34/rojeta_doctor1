import 'package:equatable/equatable.dart';

class NursingServiceModel extends Equatable {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? durationTag; // e.g. "12 Hours", "Per Visit", "Flexible"
  final List<String> bulletPoints;
  final double? price;
  final String? pricingType;
  final String? availableGender;
  final bool? isActive;

  const NursingServiceModel({
    this.id,
    this.title = '',
    this.subtitle = '',
    this.durationTag = 'Flexible',
    this.bulletPoints = const [],
    this.price,
    this.pricingType = 'Per Visit',
    this.availableGender = 'Both',
    this.isActive = true,
  });

  factory NursingServiceModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingServiceModel();

    List<String> points = [];
    if (json['bulletPoints'] is List) {
      points = (json['bulletPoints'] as List).map((e) => e.toString()).toList();
    } else if (json['bullet_points'] is List) {
      points = (json['bullet_points'] as List).map((e) => e.toString()).toList();
    } else if (json['features'] is List) {
      points = (json['features'] as List).map((e) => e.toString()).toList();
    }

    final rawPrice = json['price'] ?? json['service_price'] ?? json['fee'];
    final priceVal = rawPrice != null
        ? (rawPrice is num ? rawPrice.toDouble() : double.tryParse(rawPrice.toString()))
        : null;

    return NursingServiceModel(
      id: json['id']?.toString(),
      title: json['title'] ?? json['name'] ?? json['service_name'] ?? '',
      subtitle: json['subtitle'] ?? json['description'] ?? '',
      durationTag: json['durationTag'] ?? json['duration'] ?? json['duration_tag'] ?? 'Flexible',
      bulletPoints: points,
      price: priceVal,
      pricingType: json['pricingType'] ?? json['pricing_type'] ?? 'Per Visit',
      availableGender: json['availableGender'] ?? json['gender'] ?? json['available_gender'] ?? 'Both',
      isActive: json['isActive'] ?? json['is_active'] ?? json['status'] == 'active' ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'name': title,
      'subtitle': subtitle,
      'description': subtitle,
      'durationTag': durationTag,
      'duration': durationTag,
      'bulletPoints': bulletPoints,
      'price': price,
      'pricingType': pricingType,
      'pricing_type': pricingType,
      'availableGender': availableGender,
      'gender': availableGender,
      'isActive': isActive,
      'is_active': isActive,
    };
  }

  NursingServiceModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? durationTag,
    List<String>? bulletPoints,
    double? price,
    String? pricingType,
    String? availableGender,
    bool? isActive,
  }) {
    return NursingServiceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      durationTag: durationTag ?? this.durationTag,
      bulletPoints: bulletPoints ?? this.bulletPoints,
      price: price ?? this.price,
      pricingType: pricingType ?? this.pricingType,
      availableGender: availableGender ?? this.availableGender,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        durationTag,
        bulletPoints,
        price,
        pricingType,
        availableGender,
        isActive,
      ];
}
