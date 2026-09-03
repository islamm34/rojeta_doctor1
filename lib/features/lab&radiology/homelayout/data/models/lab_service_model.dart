import 'package:equatable/equatable.dart';

class LabServiceModel extends Equatable {
  final String id;
  final String name;
  final double price;
  final bool isHomeCollectionAvailable;
  final bool requiresFasting;
  final String turnaroundTime; // e.g., "24 hours", "48 hours"
  final String category; // e.g., "Hematology"

  const LabServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.isHomeCollectionAvailable,
    this.requiresFasting = false,
    required this.turnaroundTime,
    required this.category,
  });

  factory LabServiceModel.fromJson(Map<String, dynamic> json) {
    return LabServiceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      isHomeCollectionAvailable:
          json['isHomeCollectionAvailable'] as bool? ?? false,
      requiresFasting: json['requiresFasting'] as bool? ??
          json['requires_fasting'] as bool? ??
          false,
      turnaroundTime: json['turnaroundTime'] as String? ?? '',
      category: json['category'] as String? ?? '',
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
      ];
}
