class StaffModel {
  final String id;
  final String name;
  final String role;
  final String price;
  final String availability;
  final String? imagePath;

  StaffModel({
    required this.id,
    required this.name,
    required this.role,
    required this.price,
    required this.availability,
    this.imagePath,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      price: json['price'] as String,
      availability: json['availability'] as String,
      imagePath: json['imagePath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'price': price,
      'availability': availability,
      if (imagePath != null) 'imagePath': imagePath,
    };
  }
}
