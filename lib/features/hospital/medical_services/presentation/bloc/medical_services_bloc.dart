import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/hospital_service_model.dart';
import '../../data/models/specialty_model.dart';
import '../../domain/repositories/i_medical_services_repository.dart';
import 'medical_services_event.dart';
import 'medical_services_state.dart';

class MedicalServicesBloc
    extends Bloc<MedicalServicesEvent, MedicalServicesState> {
  final IMedicalServicesRepository repository;

  MedicalServicesBloc({required this.repository})
    : super(const MedicalServicesState()) {
    on<FetchMedicalServicesEvent>(_onFetchMedicalServices);
    on<ToggleServiceEvent>(_onToggleService);
    on<AddSpecialtyEvent>(_onAddSpecialty);
  }

  Future<void> _onFetchMedicalServices(
    FetchMedicalServicesEvent event,
    Emitter<MedicalServicesState> emit,
  ) async {
    emit(state.copyWith(status: MedicalServicesStatus.loading));

    try {
      final result = await repository.getMedicalServices();
      _emitSuccessWithCalculations(emit, result.specialties, result.services);
    } catch (_) {
      emit(state.copyWith(status: MedicalServicesStatus.failure));
    }
  }

  Future<void> _onToggleService(
    ToggleServiceEvent event,
    Emitter<MedicalServicesState> emit,
  ) async {
    final updatedServices = state.services.map((service) {
      if (service.id == event.serviceId) {
        final newStatus = !service.isEnabled;
        repository.toggleService(service.id, newStatus);
        return service.copyWith(isEnabled: newStatus);
      }
      return service;
    }).toList();

    emit(
      state.copyWith(
        status: MedicalServicesStatus.success,
        services: updatedServices,
      ),
    );
  }

  Future<void> _onAddSpecialty(
    AddSpecialtyEvent event,
    Emitter<MedicalServicesState> emit,
  ) async {
    emit(state.copyWith(status: MedicalServicesStatus.loading));

    final newSpecialty = SpecialtyModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: event.name,
      description: event.description,
      hasEmergency: event.hasEmergency,
      doctorsCount: 0,
      nursesCount: 0,
      staffList: [],
    );

    try {
      final savedSpecialty = await repository.addSpecialty(newSpecialty);
      final updatedSpecialties = List<SpecialtyModel>.from(state.specialties)
        ..add(savedSpecialty);

      _emitSuccessWithCalculations(emit, updatedSpecialties, state.services);
    } catch (_) {
      emit(state.copyWith(status: MedicalServicesStatus.failure));
    }
  }

  void _emitSuccessWithCalculations(
    Emitter<MedicalServicesState> emit,
    List<SpecialtyModel> specialties,
    List<HospitalServiceModel> services,
  ) {
    int totalDoctors = 0;
    int totalNurses = 0;
    for (var specialty in specialties) {
      totalDoctors += specialty.doctorsCount;
      totalNurses += specialty.nursesCount;
    }

    emit(
      state.copyWith(
        status: MedicalServicesStatus.success,
        services: services,
        specialties: specialties,
        isSetupComplete: specialties.isNotEmpty,
        activeSpecialtiesCount: specialties.length,
        totalStaffCount: totalDoctors + totalNurses,
      ),
    );
  }
}
