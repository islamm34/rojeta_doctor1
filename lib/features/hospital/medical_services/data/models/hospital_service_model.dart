class HospitalServiceModel {
  final String id;
  final String titleKey;
  final String descriptionKey;
  final bool isEnabled;
  final String iconPath;
  final String? extraInfoKey;
  final int? extraInfoValue;

  const HospitalServiceModel({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.isEnabled,
    required this.iconPath,
    this.extraInfoKey,
    this.extraInfoValue,
  });

  factory HospitalServiceModel.fromJson(Map<String, dynamic> json) {
    return HospitalServiceModel(
      id: json['id']?.toString() ?? '',
      titleKey:
          json['titleKey']?.toString() ??
          json['title_key']?.toString() ??
          json['title']?.toString() ??
          '',
      descriptionKey:
          json['descriptionKey']?.toString() ??
          json['description_key']?.toString() ??
          json['description']?.toString() ??
          '',
      isEnabled:
          json['isEnabled'] == true ||
          json['is_enabled'] == true ||
          json['enabled'] == true ||
          json['is_enabled'] == 1,
      iconPath:
          json['iconPath']?.toString() ??
          json['icon_path']?.toString() ??
          json['icon']?.toString() ??
          '',
      extraInfoKey:
          json['extraInfoKey']?.toString() ??
          json['extra_info_key']?.toString(),
      extraInfoValue: json['extraInfoValue'] is num
          ? (json['extraInfoValue'] as num).toInt()
          : int.tryParse(json['extra_info_value']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titleKey': titleKey,
      'descriptionKey': descriptionKey,
      'isEnabled': isEnabled,
      'iconPath': iconPath,
      'extraInfoKey': extraInfoKey,
      'extraInfoValue': extraInfoValue,
    };
  }

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
