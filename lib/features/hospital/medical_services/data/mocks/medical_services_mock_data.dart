import '../models/hospital_service_model.dart';
import '../models/specialty_model.dart';
import '../models/staff_model.dart';

class MedicalServicesMockData {
  static List<HospitalServiceModel> get initialServices => [
    HospitalServiceModel(
      id: '1',
      titleKey: 'serviceLaboratory',
      descriptionKey: 'serviceLaboratoryDesc',
      isEnabled: true,
      iconPath: 'assets/icons/laboratory.png',
    ),
    HospitalServiceModel(
      id: '2',
      titleKey: 'serviceClinics',
      descriptionKey: 'serviceClinicsDesc',
      isEnabled: true,
      iconPath: 'assets/icons/clinics.png',
    ),
    HospitalServiceModel(
      id: '3',
      titleKey: 'serviceRadiology',
      descriptionKey: 'serviceRadiologyDesc',
      isEnabled: false,
      iconPath: 'assets/icons/radiology.png',
    ),
    HospitalServiceModel(
      id: '4',
      titleKey: 'serviceAmbulance',
      descriptionKey: 'serviceAmbulanceDesc',
      isEnabled: false,
      iconPath: 'assets/icons/ambulance.png',
    ),
    HospitalServiceModel(
      id: '5',
      titleKey: 'serviceICU',
      descriptionKey: 'serviceICUDesc',
      isEnabled: true,
      iconPath: 'assets/icons/icu.png',
      extraInfoKey: 'totalIcuBeds',
      extraInfoValue: 6,
    ),
    HospitalServiceModel(
      id: '6',
      titleKey: 'serviceIncubators',
      descriptionKey: 'serviceIncubatorsDesc',
      isEnabled: false,
      iconPath: 'assets/icons/incubator.png',
    ),
    HospitalServiceModel(
      id: '7',
      titleKey: 'serviceHomeCare',
      descriptionKey: 'serviceHomeCareDesc',
      isEnabled: true,
      iconPath: 'assets/icons/home_care.png',
    ),
  ];

  static List<SpecialtyModel> get emptySpecialties => [];

  static List<SpecialtyModel> get populatedSpecialties => [
    SpecialtyModel(
      id: 's1',
      name: 'Orthopedic Clinic',
      description: 'Bones and joints',
      hasEmergency: false,
      doctorsCount: 12,
      nursesCount: 8,
      staffList: [
        StaffModel(
          id: 'd1',
          name: 'Dr. Jane Smith',
          role: 'Orthopedic Surgeon',
          price: '150EGP',
          availability: 'Mon-Fri',
          imagePath: 'assets/images/doctor.png',
        ),
      ],
    ),
    SpecialtyModel(
      id: 's2',
      name: 'Cardiology',
      description: 'Heart',
      hasEmergency: true,
      doctorsCount: 8,
      nursesCount: 15,
      staffList: [],
    ),
    SpecialtyModel(
      id: 's3',
      name: 'Pediatrics',
      description: 'Children',
      hasEmergency: true,
      doctorsCount: 6,
      nursesCount: 10,
      staffList: [],
    ),
    SpecialtyModel(
      id: 's4',
      name: 'Neurology',
      description: 'Nervous system',
      hasEmergency: false,
      doctorsCount: 6,
      nursesCount: 10,
      staffList: [],
    ),
    SpecialtyModel(
      id: 's5',
      name: 'Ophthalmology',
      description: 'Eyes',
      hasEmergency: false,
      doctorsCount: 6,
      nursesCount: 10,
      staffList: [],
    ),
  ];
}
