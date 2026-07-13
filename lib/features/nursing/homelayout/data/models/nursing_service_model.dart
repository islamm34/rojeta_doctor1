import 'package:equatable/equatable.dart';

class NursingServiceModel extends Equatable {
  final String title;
  final String subtitle;
  final String durationTag; // e.g. "12 Hours", "Per Visit", "Flexible"
  final List<String> bulletPoints;
  // final int iconColorCode;
  // final int iconCodePoint; // Using code point to map to an icon

  const NursingServiceModel({
    required this.title,
    required this.subtitle,
    required this.durationTag,
    required this.bulletPoints,
    // required this.iconColorCode,
    // required this.iconCodePoint,
  });

  factory NursingServiceModel.fromJson(Map<String, dynamic> json) {
    return NursingServiceModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      durationTag: json['durationTag'] ?? '',
      bulletPoints: List<String>.from(json['bulletPoints'] ?? []),
      // iconColorCode: json['iconColorCode'] ?? 0xFF000000,
      // iconCodePoint: json['iconCodePoint'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'durationTag': durationTag,
      'bulletPoints': bulletPoints,
      // 'iconColorCode': iconColorCode,
      // 'iconCodePoint': iconCodePoint,
    };
  }

  @override
  List<Object?> get props => [
        title,
        subtitle,
        durationTag,
        bulletPoints,
        // iconColorCode,
        // iconCodePoint,
      ];
}
