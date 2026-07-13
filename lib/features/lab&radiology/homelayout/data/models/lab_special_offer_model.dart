import 'package:equatable/equatable.dart';

class LabSpecialOfferModel extends Equatable {
  final String title;
  final String description;
  final String discount;

  const LabSpecialOfferModel({
    required this.title,
    required this.description,
    required this.discount,
  });

  factory LabSpecialOfferModel.fromJson(Map<String, dynamic> json) {
    return LabSpecialOfferModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      discount: json['discount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'discount': discount,
    };
  }

  @override
  List<Object?> get props => [title, description, discount];
}
