import 'package:equatable/equatable.dart';

enum HomelayoutStatus { initial, loading, loaded, error }

class HomelayoutState extends Equatable {
  const HomelayoutState({
    this.status = HomelayoutStatus.initial,
    this.message = '',
    // final HomelayoutEntity? entity,
  });

  final HomelayoutStatus status;
  final String message;
  // final HomelayoutEntity? entity;

  HomelayoutState copyWith({
    HomelayoutStatus? status,
    String? message,
    // HomelayoutEntity? entity,
  }) {
    return HomelayoutState(
      status: status ?? this.status,
      message: message ?? this.message,
      // entity: entity ?? this.entity,
    );
  }

  @override
  List<Object> get props => [status, message]; // props..add(entity)
}
