import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/hospital_service_model.dart';
import 'medical_services_event.dart';
import 'medical_services_state.dart';
import '../../data/mocks/medical_services_mock_data.dart';
import '../../data/models/specialty_model.dart';

class MedicalServicesBloc
    extends Bloc<MedicalServicesEvent, MedicalServicesState> {
  MedicalServicesBloc() : super(const MedicalServicesState()) {
    on<FetchMedicalServicesEvent>(_onFetchMedicalServices);
    on<ToggleServiceEvent>(_onToggleService);
    on<AddSpecialtyEvent>(_onAddSpecialty);
  }

  void _onFetchMedicalServices(
    FetchMedicalServicesEvent event,
    Emitter<MedicalServicesState> emit,
  ) async {
    emit(state.copyWith(status: MedicalServicesStatus.loading));

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Start with empty specialties to show the setup flow.
    // Replace with MedicalServicesMockData.populatedSpecialties to see populated flow.
    final specialties = MedicalServicesMockData.emptySpecialties;
    final services = MedicalServicesMockData.initialServices;

    _emitSuccessWithCalculations(emit, specialties, services);
  }

  void _onToggleService(
    ToggleServiceEvent event,
    Emitter<MedicalServicesState> emit,
  ) {
    final updatedServices = state.services.map((service) {
      if (service.id == event.serviceId) {
        return service.copyWith(isEnabled: !service.isEnabled);
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

  void _onAddSpecialty(
    AddSpecialtyEvent event,
    Emitter<MedicalServicesState> emit,
  ) async {
    emit(state.copyWith(status: MedicalServicesStatus.loading));

    await Future.delayed(const Duration(milliseconds: 600));

    final newSpecialty = SpecialtyModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: event.name,
      description: event.description,
      hasEmergency: event.hasEmergency,
      doctorsCount: 0,
      nursesCount: 0,
      staffList: [],
    );

    final updatedSpecialties = List<SpecialtyModel>.from(state.specialties)
      ..add(newSpecialty);

    _emitSuccessWithCalculations(emit, updatedSpecialties, state.services);
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
