import 'package:equatable/equatable.dart';

abstract class LabHomeEvent extends Equatable {
  const LabHomeEvent();

  @override
  List<Object> get props => [];
}

class LoadLabHomeDataEvent extends LabHomeEvent {}
