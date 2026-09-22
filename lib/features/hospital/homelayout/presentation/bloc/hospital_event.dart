import 'package:equatable/equatable.dart';

abstract class HospitalEvent extends Equatable {
  const HospitalEvent();

  @override
  List<Object?> get props => [];
}

class LoadHospitalDashboardEvent extends HospitalEvent {
  const LoadHospitalDashboardEvent();
}
