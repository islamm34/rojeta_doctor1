import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/error/exceptions.dart';
import '../../data/repositories/doctor_appointments_repository.dart';
import '../../data/repositories/doctor_dashboard_repository.dart';
import 'homelayout_event.dart';
import 'homelayout_state.dart';

class HomelayoutBloc extends Bloc<HomelayoutEvent, HomelayoutState> {
  final DoctorDashboardRepository dashboardRepository;
  final DoctorAppointmentsRepository appointmentsRepository;

  HomelayoutBloc({
    required this.dashboardRepository,
    required this.appointmentsRepository,
  }) : super(const HomelayoutState()) {
    on<LoadHomelayoutEvent>(_onLoad);
  }

  FutureOr<void> _onLoad(
    LoadHomelayoutEvent event,
    Emitter<HomelayoutState> emit,
  ) async {
    emit(state.copyWith(status: HomelayoutStatus.loading, errorMessage: null));
    try {
      final results = await Future.wait([
        dashboardRepository.getDashboardStats(),
        dashboardRepository.getProfileSummary(),
        appointmentsRepository.getAppointments(limit: 5),
      ]);

      emit(state.copyWith(
        status: HomelayoutStatus.success,
        stats: results[0] as dynamic,
        profileSummary: results[1] as dynamic,
        upcomingAppointments: results[2] as dynamic,
      ));
    } catch (e) {
      final errorMessage = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(state.copyWith(
        status: HomelayoutStatus.failure,
        errorMessage: errorMessage,
      ));
    }
  }
}
