import 'package:equatable/equatable.dart';

class CreateLabServiceModel extends Equatable {
  final String? name;
  final double? price;
  final String? category;
  final String? preparations;
  final bool? isHomeCollectionAvailable;
  final String? turnaroundTime;

  const CreateLabServiceModel({
    this.name,
    this.price,
    this.category,
    this.preparations,
    this.isHomeCollectionAvailable,
    this.turnaroundTime,
  });

  factory CreateLabServiceModel.fromJson(Map<String, dynamic> json) {
    return CreateLabServiceModel(
      name: (json['name'] ?? json['title'] ?? json['service_name']) as String?,
      price: (json['price'] as num?)?.toDouble() ??
          (json['cost'] as num?)?.toDouble() ??
          (json['fee'] as num?)?.toDouble(),
      category: (json['category'] ?? json['category_name'] ?? json['department']) as String?,
      preparations: (json['preparations'] ?? json['instructions'] ?? json['notes']) as String?,
      isHomeCollectionAvailable:
          json['isHomeCollectionAvailable'] as bool? ??
          json['is_home_collection_available'] as bool? ??
          json['home_collection'] as bool?,
      turnaroundTime: (json['turnaroundTime'] ?? json['turnaround_time'] ?? json['duration']) as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (category != null) 'category': category,
      if (preparations != null) 'preparations': preparations,
      if (isHomeCollectionAvailable != null)
        'is_home_collection_available': isHomeCollectionAvailable,
      if (turnaroundTime != null) 'turnaround_time': turnaroundTime,
    };
  }

  CreateLabServiceModel copyWith({
    String? name,
    double? price,
    String? category,
    String? preparations,
    bool? isHomeCollectionAvailable,
    String? turnaroundTime,
  }) {
    return CreateLabServiceModel(
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      preparations: preparations ?? this.preparations,
      isHomeCollectionAvailable: isHomeCollectionAvailable ?? this.isHomeCollectionAvailable,
      turnaroundTime: turnaroundTime ?? this.turnaroundTime,
    );
  }

  @override
  List<Object?> get props => [
        name,
        price,
        category,
        preparations,
        isHomeCollectionAvailable,
        turnaroundTime,
      ];
}
