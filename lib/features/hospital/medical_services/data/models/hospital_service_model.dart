class HospitalServiceModel {
  final String id;
  final String titleKey;
  final String descriptionKey;
  final bool isEnabled;
  final String iconPath;
  final String? extraInfoKey;
  final int? extraInfoValue;

  HospitalServiceModel({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.isEnabled,
    required this.iconPath,
    this.extraInfoKey,
    this.extraInfoValue,
  });

  HospitalServiceModel copyWith({
    String? id,
    String? titleKey,
    String? descriptionKey,
    bool? isEnabled,
    String? iconPath,
    String? extraInfoKey,
    int? extraInfoValue,
  }) {
    return HospitalServiceModel(
      id: id ?? this.id,
      titleKey: titleKey ?? this.titleKey,
      descriptionKey: descriptionKey ?? this.descriptionKey,
      isEnabled: isEnabled ?? this.isEnabled,
      iconPath: iconPath ?? this.iconPath,
      extraInfoKey: extraInfoKey ?? this.extraInfoKey,
      extraInfoValue: extraInfoValue ?? this.extraInfoValue,
    );
  }
}
