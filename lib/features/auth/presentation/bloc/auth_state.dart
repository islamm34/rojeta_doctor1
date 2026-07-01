import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, loaded, error }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.message = '',
    // final AuthEntity? entity,
  });

  final AuthStatus status;
  final String message;
  // final AuthEntity? entity;

  AuthState copyWith({
    AuthStatus? status,
    String? message,
    // AuthEntity? entity,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
      // entity: entity ?? this.entity,
    );
  }

  @override
  List<Object> get props => [status, message]; // props..add(entity)
}
