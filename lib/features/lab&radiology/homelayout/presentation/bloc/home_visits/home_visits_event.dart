import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/features/lab&radiology/homelayout/data/models/home_visit_config_model.dart';

import '../../../../../../features/auth/data/models/user_type_model.dart';

abstract class HomeVisitsEvent extends Equatable {
  const HomeVisitsEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeVisitsConfig extends HomeVisitsEvent {
  final UserType userType;

  const LoadHomeVisitsConfig({required this.userType});

  @override
  List<Object> get props => [userType];
}

class ToggleServiceStatus extends HomeVisitsEvent {}

class UpdateCollectionFee extends HomeVisitsEvent {
  final double fee;

  const UpdateCollectionFee(this.fee);

  @override
  List<Object> get props => [fee];
}

class UpdateMinimumBooking extends HomeVisitsEvent {
  final double amount;

  const UpdateMinimumBooking(this.amount);

  @override
  List<Object> get props => [amount];
}

class ToggleWeekdaysTab extends HomeVisitsEvent {
  final bool isWeekdays;

  const ToggleWeekdaysTab({required this.isWeekdays});

  @override
  List<Object> get props => [isWeekdays];
}

class AddHomeVisitTimeSlot extends HomeVisitsEvent {
  final TimeSlotModel slot;
  final bool isWeekday;

  const AddHomeVisitTimeSlot({required this.slot, required this.isWeekday});

  @override
  List<Object> get props => [slot, isWeekday];
}

class RemoveHomeVisitTimeSlot extends HomeVisitsEvent {
  final int index;
  final bool isWeekday;

  const RemoveHomeVisitTimeSlot({required this.index, required this.isWeekday});

  @override
  List<Object> get props => [index, isWeekday];
}

class ToggleHomeVisitTimeSlotStatus extends HomeVisitsEvent {
  final int index;
  final bool isWeekday;

  const ToggleHomeVisitTimeSlotStatus({
    required this.index,
    required this.isWeekday,
  });

  @override
  List<Object> get props => [index, isWeekday];
}

class AddHomeVisitServiceArea extends HomeVisitsEvent {
  final ServiceAreaModel area;

  const AddHomeVisitServiceArea({required this.area});

  @override
  List<Object> get props => [area];
}

class DeleteHomeVisitServiceArea extends HomeVisitsEvent {
  final String areaId;

  const DeleteHomeVisitServiceArea({required this.areaId});

  @override
  List<Object> get props => [areaId];
}

class SaveHomeVisitsConfig extends HomeVisitsEvent {}
