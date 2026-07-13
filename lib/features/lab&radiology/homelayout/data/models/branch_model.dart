import 'package:equatable/equatable.dart';

class BranchModel extends Equatable {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String workingHours;
  final bool isHomeCollectionAvailable;
  final String? imageUrl; // For map placeholder

  const BranchModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.workingHours,
    required this.isHomeCollectionAvailable,
    this.imageUrl,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      workingHours: json['workingHours'] as String,
      isHomeCollectionAvailable: json['isHomeCollectionAvailable'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'workingHours': workingHours,
      'isHomeCollectionAvailable': isHomeCollectionAvailable,
      'imageUrl': imageUrl,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        phone,
        workingHours,
        isHomeCollectionAvailable,
        imageUrl,
      ];
}
