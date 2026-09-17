import 'package:equatable/equatable.dart';

class BranchModel extends Equatable {
  final String? id;
  final String? name;
  final String? address;
  final String? phone;
  final String? workingHours;
  final bool? isHomeCollectionAvailable;
  final String? imageUrl;
  final String? mapUrl;

  const BranchModel({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.workingHours,
    this.isHomeCollectionAvailable,
    this.imageUrl,
    this.mapUrl,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    final imgUrl = (json['imageUrl'] ?? json['image_url'] ?? json['image']) as String?;
    final map = (json['mapUrl'] ?? json['map_url'] ?? json['location_url']) as String?;
    return BranchModel(
      id: (json['id'] ?? json['_id'])?.toString(),
      name: (json['name'] ?? json['branch_name'] ?? json['title']) as String?,
      address: (json['address'] ?? json['location'] ?? json['branch_address']) as String?,
      phone: (json['phone'] ?? json['phone_number'] ?? json['telephone']) as String?,
      workingHours: (json['workingHours'] ?? json['working_hours'] ?? json['hours']) as String?,
      isHomeCollectionAvailable:
          json['isHomeCollectionAvailable'] as bool? ??
          json['is_home_collection_available'] as bool? ??
          json['home_collection'] as bool?,
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

  BranchModel copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    String? workingHours,
    bool? isHomeCollectionAvailable,
    String? imageUrl,
    String? mapUrl,
  }) {
    return BranchModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      workingHours: workingHours ?? this.workingHours,
      isHomeCollectionAvailable: isHomeCollectionAvailable ?? this.isHomeCollectionAvailable,
      imageUrl: imageUrl ?? this.imageUrl,
      mapUrl: mapUrl ?? this.mapUrl,
    );
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
