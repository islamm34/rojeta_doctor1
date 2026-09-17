import 'package:equatable/equatable.dart';

import '../../../../auth/data/models/user_type_model.dart';

abstract class LabHomeEvent extends Equatable {
  const LabHomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadLabHomeDataEvent extends LabHomeEvent {
  final UserType? userType;

  const LoadLabHomeDataEvent({this.userType});

  @override
  List<Object?> get props => [userType];
}
