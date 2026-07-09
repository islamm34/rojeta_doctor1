enum UserType {
  doctor,
  hospital,
  radiologyCenter,
  laboratory,
  nursingCareProviders,
  clinic,
  nursingCare,
}

class UserTypeModel {
  final UserType type;
  final String titleKey;
  final String imagePath;

  UserTypeModel({
    required this.type,
    required this.titleKey,
    required this.imagePath,
  });
}
