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

  List<DoctorSubSpecialty> get subSpecialties =>
      DoctorSubSpecialty.values.where((s) => s.specialty == this).toList();
}

enum DoctorSubSpecialty {
  // Cardiology
  cardioInterventional('cardio_interventional', DoctorSpecialty.cardiology),
  cardioElectrophysiology(
    'cardio_electrophysiology',
    DoctorSpecialty.cardiology,
  ),
  cardioCardiothoracicSurgery(
    'cardio_cardiothoracic_surgery',
    DoctorSpecialty.cardiology,
  ),
  cardioPediatric('cardio_pediatric', DoctorSpecialty.cardiology),
  cardioHeartFailure('cardio_heart_failure', DoctorSpecialty.cardiology),
  cardioImaging('cardio_imaging', DoctorSpecialty.cardiology),
  cardioValvular('cardio_valvular', DoctorSpecialty.cardiology),
  cardioGeneral('cardio_general', DoctorSpecialty.cardiology),

  // Pediatrics
  pedNeonatology('ped_neonatology', DoctorSpecialty.pediatrics),
  pedGeneral('ped_general', DoctorSpecialty.pediatrics),
  pedCardiology('ped_cardiology', DoctorSpecialty.pediatrics),
  pedPulmonology('ped_pulmonology', DoctorSpecialty.pediatrics),
  pedEndocrinology('ped_endocrinology', DoctorSpecialty.pediatrics),
  pedGastroenterology('ped_gastroenterology', DoctorSpecialty.pediatrics),
  pedNeurology('ped_neurology', DoctorSpecialty.pediatrics),
  pedNephrology('ped_nephrology', DoctorSpecialty.pediatrics),

  // Ophthalmology
  ophtRetina('opht_retina', DoctorSpecialty.ophthalmology),
  ophtCorneaRefractive('opht_cornea_refractive', DoctorSpecialty.ophthalmology),
  ophtGlaucoma('opht_glaucoma', DoctorSpecialty.ophthalmology),
  ophtPediatric('opht_pediatric', DoctorSpecialty.ophthalmology),
  ophtOculoplastics('opht_oculoplastics', DoctorSpecialty.ophthalmology),
  ophtNeuro('opht_neuro', DoctorSpecialty.ophthalmology),
  ophtGeneral('opht_general', DoctorSpecialty.ophthalmology),

  // Orthopedics
  orthoJointReplacement(
    'ortho_joint_replacement',
    DoctorSpecialty.orthopedics,
  ),
  orthoSpine('ortho_spine', DoctorSpecialty.orthopedics),
  orthoSportsInjuries('ortho_sports_injuries', DoctorSpecialty.orthopedics),
  orthoPediatric('ortho_pediatric', DoctorSpecialty.orthopedics),
  orthoHand('ortho_hand', DoctorSpecialty.orthopedics),
  orthoFootAnkle('ortho_foot_ankle', DoctorSpecialty.orthopedics),
  orthoBoneTumors('ortho_bone_tumors', DoctorSpecialty.orthopedics),
  orthoGeneral('ortho_general', DoctorSpecialty.orthopedics),

  // Neurology
  neuroSurgery('neuro_surgery', DoctorSpecialty.neurology),
  neuroStroke('neuro_stroke', DoctorSpecialty.neurology),
  neuroEpilepsy('neuro_epilepsy', DoctorSpecialty.neurology),
  neuroMovementDisorders(
    'neuro_movement_disorders',
    DoctorSpecialty.neurology,
  ),
  neuroMultipleSclerosis(
    'neuro_multiple_sclerosis',
    DoctorSpecialty.neurology,
  ),
  neuroNeuromuscular('neuro_neuromuscular', DoctorSpecialty.neurology),
  neuroHeadachePain('neuro_headache_pain', DoctorSpecialty.neurology),
  neuroGeneral('neuro_general', DoctorSpecialty.neurology),

  // General
  genInternalMedicine('gen_internal_medicine', DoctorSpecialty.general),
  genPractice('gen_practice', DoctorSpecialty.general),
  genFamilyMedicine('gen_family_medicine', DoctorSpecialty.general),
  genGastroenterology('gen_gastroenterology', DoctorSpecialty.general),
  genEndocrinology('gen_endocrinology', DoctorSpecialty.general),
  genNephrology('gen_nephrology', DoctorSpecialty.general),
  genEmergency('gen_emergency', DoctorSpecialty.general),
  genGeriatrics('gen_geriatrics', DoctorSpecialty.general);

  final String value;
  final DoctorSpecialty specialty;
  const DoctorSubSpecialty(this.value, this.specialty);

  String localizedName(BuildContext context) {
    switch (this) {
      case DoctorSubSpecialty.cardioInterventional:
        return context.strings.subSpecialtyCardioInterventional;
      case DoctorSubSpecialty.cardioElectrophysiology:
        return context.strings.subSpecialtyCardioElectrophysiology;
      case DoctorSubSpecialty.cardioCardiothoracicSurgery:
        return context.strings.subSpecialtyCardioCardiothoracicSurgery;
      case DoctorSubSpecialty.cardioPediatric:
        return context.strings.subSpecialtyCardioPediatric;
      case DoctorSubSpecialty.cardioHeartFailure:
        return context.strings.subSpecialtyCardioHeartFailure;
      case DoctorSubSpecialty.cardioImaging:
        return context.strings.subSpecialtyCardioImaging;
      case DoctorSubSpecialty.cardioValvular:
        return context.strings.subSpecialtyCardioValvular;
      case DoctorSubSpecialty.cardioGeneral:
        return context.strings.subSpecialtyCardioGeneral;

      case DoctorSubSpecialty.pedNeonatology:
        return context.strings.subSpecialtyPedNeonatology;
      case DoctorSubSpecialty.pedGeneral:
        return context.strings.subSpecialtyPedGeneral;
      case DoctorSubSpecialty.pedCardiology:
        return context.strings.subSpecialtyPedCardiology;
      case DoctorSubSpecialty.pedPulmonology:
        return context.strings.subSpecialtyPedPulmonology;
      case DoctorSubSpecialty.pedEndocrinology:
        return context.strings.subSpecialtyPedEndocrinology;
      case DoctorSubSpecialty.pedGastroenterology:
        return context.strings.subSpecialtyPedGastroenterology;
      case DoctorSubSpecialty.pedNeurology:
        return context.strings.subSpecialtyPedNeurology;
      case DoctorSubSpecialty.pedNephrology:
        return context.strings.subSpecialtyPedNephrology;

      case DoctorSubSpecialty.ophtRetina:
        return context.strings.subSpecialtyOphtRetina;
      case DoctorSubSpecialty.ophtCorneaRefractive:
        return context.strings.subSpecialtyOphtCorneaRefractive;
      case DoctorSubSpecialty.ophtGlaucoma:
        return context.strings.subSpecialtyOphtGlaucoma;
      case DoctorSubSpecialty.ophtPediatric:
        return context.strings.subSpecialtyOphtPediatric;
      case DoctorSubSpecialty.ophtOculoplastics:
        return context.strings.subSpecialtyOphtOculoplastics;
      case DoctorSubSpecialty.ophtNeuro:
        return context.strings.subSpecialtyOphtNeuro;
      case DoctorSubSpecialty.ophtGeneral:
        return context.strings.subSpecialtyOphtGeneral;

      case DoctorSubSpecialty.orthoJointReplacement:
        return context.strings.subSpecialtyOrthoJointReplacement;
      case DoctorSubSpecialty.orthoSpine:
        return context.strings.subSpecialtyOrthoSpine;
      case DoctorSubSpecialty.orthoSportsInjuries:
        return context.strings.subSpecialtyOrthoSportsInjuries;
      case DoctorSubSpecialty.orthoPediatric:
        return context.strings.subSpecialtyOrthoPediatric;
      case DoctorSubSpecialty.orthoHand:
        return context.strings.subSpecialtyOrthoHand;
      case DoctorSubSpecialty.orthoFootAnkle:
        return context.strings.subSpecialtyOrthoFootAnkle;
      case DoctorSubSpecialty.orthoBoneTumors:
        return context.strings.subSpecialtyOrthoBoneTumors;
      case DoctorSubSpecialty.orthoGeneral:
        return context.strings.subSpecialtyOrthoGeneral;

      case DoctorSubSpecialty.neuroSurgery:
        return context.strings.subSpecialtyNeuroSurgery;
      case DoctorSubSpecialty.neuroStroke:
        return context.strings.subSpecialtyNeuroStroke;
      case DoctorSubSpecialty.neuroEpilepsy:
        return context.strings.subSpecialtyNeuroEpilepsy;
      case DoctorSubSpecialty.neuroMovementDisorders:
        return context.strings.subSpecialtyNeuroMovementDisorders;
      case DoctorSubSpecialty.neuroMultipleSclerosis:
        return context.strings.subSpecialtyNeuroMultipleSclerosis;
      case DoctorSubSpecialty.neuroNeuromuscular:
        return context.strings.subSpecialtyNeuroNeuromuscular;
      case DoctorSubSpecialty.neuroHeadachePain:
        return context.strings.subSpecialtyNeuroHeadachePain;
      case DoctorSubSpecialty.neuroGeneral:
        return context.strings.subSpecialtyNeuroGeneral;

      case DoctorSubSpecialty.genInternalMedicine:
        return context.strings.subSpecialtyGenInternalMedicine;
      case DoctorSubSpecialty.genPractice:
        return context.strings.subSpecialtyGenPractice;
      case DoctorSubSpecialty.genFamilyMedicine:
        return context.strings.subSpecialtyGenFamilyMedicine;
      case DoctorSubSpecialty.genGastroenterology:
        return context.strings.subSpecialtyGenGastroenterology;
      case DoctorSubSpecialty.genEndocrinology:
        return context.strings.subSpecialtyGenEndocrinology;
      case DoctorSubSpecialty.genNephrology:
        return context.strings.subSpecialtyGenNephrology;
      case DoctorSubSpecialty.genEmergency:
        return context.strings.subSpecialtyGenEmergency;
      case DoctorSubSpecialty.genGeriatrics:
        return context.strings.subSpecialtyGenGeriatrics;
    }
  }

  static DoctorSubSpecialty? fromString(
    String? val, {
    DoctorSpecialty? specialty,
    BuildContext? context,
  }) {
    if (val == null || val.trim().isEmpty) return null;
    final normalized = val.trim().toLowerCase();

    final searchList = specialty != null
        ? specialty.subSpecialties
        : DoctorSubSpecialty.values;

    for (final sub in searchList) {
      if (sub.value.toLowerCase() == normalized ||
          sub.name.toLowerCase() == normalized) {
        return sub;
      }
      if (context != null &&
          sub.localizedName(context).toLowerCase() == normalized) {
        return sub;
      }
    }
    return null;
  }

  static String localizedNameFromValue(BuildContext context, String? val) {
    if (val == null || val.isEmpty) return '';
    final sub = DoctorSubSpecialty.fromString(val, context: context);
    return sub != null ? sub.localizedName(context) : val;
  }
}

typedef Specialty = DoctorSpecialty;
