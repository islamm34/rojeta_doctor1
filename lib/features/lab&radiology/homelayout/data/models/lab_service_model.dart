import 'package:equatable/equatable.dart';

class LabServiceModel extends Equatable {
  final String id;
  final String name;
  final double price;
  final bool isHomeCollectionAvailable;
  final String turnaroundTime; // e.g., "24 hours", "48 hours"
  final String category; // e.g., "Hematology"

  const LabServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.isHomeCollectionAvailable,
    required this.turnaroundTime,
    required this.category,
  });

  factory LabServiceModel.fromJson(Map<String, dynamic> json) {
    return LabServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      isHomeCollectionAvailable: json['isHomeCollectionAvailable'] ?? false,
      turnaroundTime: json['turnaroundTime'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isHomeCollectionAvailable': isHomeCollectionAvailable,
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
        turnaroundTime,
        category,
      ];
}
