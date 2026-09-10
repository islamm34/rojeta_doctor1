import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';

enum DoctorSpecialty {
  cardiology('cardiology'),
  pediatrics('pediatrics'),
  ophthalmology('ophthalmology'),
  orthopedics('orthopedics'),
  neurology('neurology'),
  general('general');

  final String value;
  const DoctorSpecialty(this.value);

  static DoctorSpecialty? fromString(String? val) {
    if (val == null || val.trim().isEmpty) return null;
    final normalized = val.trim().toLowerCase();
    for (final specialty in DoctorSpecialty.values) {
      if (specialty.value.toLowerCase() == normalized ||
          specialty.name.toLowerCase() == normalized) {
        return specialty;
      }
    }
    return null;
  }

  String localizedName(BuildContext context) {
    switch (this) {
      case DoctorSpecialty.cardiology:
        return context.strings.cardiology;
      case DoctorSpecialty.pediatrics:
        return context.strings.pediatrics;
      case DoctorSpecialty.ophthalmology:
        return context.strings.ophthalmology;
      case DoctorSpecialty.orthopedics:
        return context.strings.orthopedics;
      case DoctorSpecialty.neurology:
        return context.strings.neurology;
      case DoctorSpecialty.general:
        return context.strings.general;
    }
  }

  static String localizedNameFromValue(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return '';
    final specialty = DoctorSpecialty.fromString(val);
    return specialty != null ? specialty.localizedName(context) : val;
  }
}

typedef Specialty = DoctorSpecialty;
