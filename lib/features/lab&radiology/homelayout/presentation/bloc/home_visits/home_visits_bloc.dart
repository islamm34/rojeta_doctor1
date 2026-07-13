import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_visits_event.dart';
import 'home_visits_state.dart';
import '../../../data/models/home_visit_config_model.dart';

class HomeVisitsBloc extends Bloc<HomeVisitsEvent, HomeVisitsState> {
  HomeVisitsBloc() : super(const HomeVisitsState()) {
    on<LoadHomeVisitsConfig>(_onLoadConfig);
    on<ToggleServiceStatus>(_onToggleStatus);
    on<UpdateCollectionFee>(_onUpdateFee);
    on<UpdateMinimumBooking>(_onUpdateMinimumBooking);
    on<ToggleWeekdaysTab>(_onToggleWeekdaysTab);
    on<SaveHomeVisitsConfig>(_onSaveConfig);
  }

  Future<void> _onLoadConfig(LoadHomeVisitsConfig event, Emitter<HomeVisitsState> emit) async {
    emit(state.copyWithClearError(status: HomeVisitsStatus.loading));
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Dummy mock data based on screenshot
    final config = HomeVisitConfigModel(
      isServiceVisible: true,
      collectionFee: 50.00,
      minimumBookingAmount: 100.00,
      isWeekdaysTabActive: true,
      serviceAreas: const [
        ServiceAreaModel(id: '1', name: 'Nasr City', radiusKm: 15, techsAvailable: 4),
        ServiceAreaModel(id: '2', name: 'Downtown Central', radiusKm: 5, techsAvailable: 2),
      ],
      weekdaySlots: const [
        TimeSlotModel(id: 'w1', time: '06:00', amPm: 'AM SLOT', status: TimeSlotStatus.active),
        TimeSlotModel(id: 'w2', time: '08:00', amPm: 'AM SLOT', status: TimeSlotStatus.ready),
        TimeSlotModel(id: 'w3', time: '10:00', amPm: 'AM SLOT', status: TimeSlotStatus.ready),
        TimeSlotModel(id: 'w4', time: '12:00', amPm: 'PM SLOT', status: TimeSlotStatus.active),
        TimeSlotModel(id: 'w5', time: '02:00', amPm: 'PM SLOT', status: TimeSlotStatus.disabled),
      ],
      weekendSlots: const [
        TimeSlotModel(id: 'we1', time: '10:00', amPm: 'AM SLOT', status: TimeSlotStatus.active),
        TimeSlotModel(id: 'we2', time: '12:00', amPm: 'PM SLOT', status: TimeSlotStatus.ready),
      ],
    );

    emit(state.copyWithClearError(
      status: HomeVisitsStatus.success,
      config: config,
    ));
  }

  void _onToggleStatus(ToggleServiceStatus event, Emitter<HomeVisitsState> emit) {
    emit(state.copyWithClearError(
      config: state.config.copyWith(
        isServiceVisible: !state.config.isServiceVisible,
      ),
    ));
  }

  void _onUpdateFee(UpdateCollectionFee event, Emitter<HomeVisitsState> emit) {
    emit(state.copyWithClearError(
      config: state.config.copyWith(
        collectionFee: event.fee,
      ),
    ));
  }

  void _onUpdateMinimumBooking(UpdateMinimumBooking event, Emitter<HomeVisitsState> emit) {
    emit(state.copyWithClearError(
      config: state.config.copyWith(
        minimumBookingAmount: event.amount,
      ),
    ));
  }

  void _onToggleWeekdaysTab(ToggleWeekdaysTab event, Emitter<HomeVisitsState> emit) {
    emit(state.copyWithClearError(
      config: state.config.copyWith(
        isWeekdaysTabActive: event.isWeekdays,
      ),
    ));
  }

  Future<void> _onSaveConfig(SaveHomeVisitsConfig event, Emitter<HomeVisitsState> emit) async {
    emit(state.copyWithClearError(status: HomeVisitsStatus.saving));
    
    // Simulate network save
    await Future.delayed(const Duration(seconds: 1));
    
    emit(state.copyWithClearError(status: HomeVisitsStatus.saveSuccess));
    // Reset to success to allow further editing without re-triggering save actions
    emit(state.copyWithClearError(status: HomeVisitsStatus.success));
  }
}
