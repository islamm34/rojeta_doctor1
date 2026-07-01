import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String id;
  final String title;

  const AuthEntity({required this.id, required this.title});
  
  @override
  List<Object> get props => [id, title];
}
