import 'package:equatable/equatable.dart';

abstract class HomelayoutEvent extends Equatable {
  const HomelayoutEvent();
  @override
  List<Object> get props => [];
}

class LoadHomelayoutEvent extends HomelayoutEvent {}
