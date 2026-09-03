import 'package:equatable/equatable.dart';

class BranchModel extends Equatable {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String workingHours;
  final bool isHomeCollectionAvailable;
  final String? imageUrl; // For map placeholder
  final String? mapUrl;

  const BranchModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.workingHours,
    required this.isHomeCollectionAvailable,
    this.imageUrl,
    this.mapUrl,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    final imgUrl = json['imageUrl'] as String?;
    final map = json['mapUrl'] as String?;
    return BranchModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      workingHours: json['workingHours'] as String? ?? '',
      isHomeCollectionAvailable:
          json['isHomeCollectionAvailable'] as bool? ?? false,
      imageUrl: imgUrl ?? map,
      mapUrl: map ?? imgUrl,
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
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (mapUrl != null) 'mapUrl': mapUrl,
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
        mapUrl,
      ];
}
