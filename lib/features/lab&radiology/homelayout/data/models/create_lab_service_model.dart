import 'package:equatable/equatable.dart';

class CreateLabServiceModel extends Equatable {
  final String name;
  final double price;
  final String category;
  final String preparations;
  final bool isHomeCollectionAvailable;
  final String turnaroundTime; 

  const CreateLabServiceModel({
    required this.name,
    required this.price,
    required this.category,
    required this.preparations,
    required this.isHomeCollectionAvailable,
    required this.turnaroundTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'preparations': preparations,
      'isHomeCollectionAvailable': isHomeCollectionAvailable,
      'turnaroundTime': turnaroundTime,
    };
  }

  @override
  List<Object?> get props => [
        name,
        price,
        category,
        preparations,
        isHomeCollectionAvailable,
        turnaroundTime,
      ];
}
