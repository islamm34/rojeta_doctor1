import 'package:equatable/equatable.dart';

class DoctorProfileModel extends Equatable {
  final String name;
  final String specialty;
  final String imageUrl;

  const DoctorProfileModel({
    required this.name,
    required this.specialty,
    required this.imageUrl,
  });

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      name: json['name'] as String? ?? '',
      specialty: json['specialty'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specialty': specialty,
      'imageUrl': imageUrl,
    };
  }

  DoctorProfileModel copyWith({
    String? name,
    String? specialty,
    String? imageUrl,
  }) {
    return DoctorProfileModel(
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [name, specialty, imageUrl];
}
