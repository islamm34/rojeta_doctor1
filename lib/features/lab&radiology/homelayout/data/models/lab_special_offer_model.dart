import 'package:equatable/equatable.dart';

class LabSpecialOfferModel extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? discount;

  const LabSpecialOfferModel({
    this.id,
    this.title,
    this.description,
    this.discount,
  });

  factory LabSpecialOfferModel.fromJson(Map<String, dynamic> json) {
    return LabSpecialOfferModel(
      id: (json['id'] ?? json['_id'])?.toString(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      discount: json['discount']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'discount': discount,
    };
  }

  @override
  List<Object?> get props => [id, title, description, discount];
}
