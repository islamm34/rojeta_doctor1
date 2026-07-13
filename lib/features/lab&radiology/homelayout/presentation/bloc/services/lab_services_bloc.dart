import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';
import '../../../data/models/lab_service_model.dart';
import 'lab_services_event.dart';
import 'lab_services_state.dart';

class LabServicesBloc extends Bloc<LabServicesEvent, LabServicesState> {
  LabServicesBloc() : super(const LabServicesState()) {
    on<FetchLabServicesEvent>(_onFetchLabServices);
  }

  Future<void> _onFetchLabServices(
    FetchLabServicesEvent event,
    Emitter<LabServicesState> emit,
  ) async {
    emit(state.copyWith(status: LabServicesStatus.loading, clearError: true));

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      final List<LabServiceModel> mockServices;
      final int totalActive;
      final int homeVisits;

      if (event.userType == UserType.radiologyCenter) {
        mockServices = [
          const LabServiceModel(
            id: '1',
            name: 'X-Ray',
            price: 150.0,
            isHomeCollectionAvailable: false,
            turnaroundTime: '72 hours',
            category: 'Radiology',
          ),
          const LabServiceModel(
            id: '2',
            name: 'CT Scan',
            price: 150.0,
            isHomeCollectionAvailable: false,
            turnaroundTime: '24 hours',
            category: 'Radiology',
          ),
          const LabServiceModel(
            id: '3',
            name: 'X-Ray',
            price: 450.0,
            isHomeCollectionAvailable: true,
            turnaroundTime: '48 hours',
            category: 'Radiology',
          ),
          const LabServiceModel(
            id: '4',
            name: 'Ultrasound',
            price: 450.0,
            isHomeCollectionAvailable: true,
            turnaroundTime: '48 hours',
            category: 'Radiology',
          ),
        ];
        totalActive = 142;
        homeVisits = 0; // Not prominently shown in Radiology top bar based on mockup
      } else {
        // Laboratory
        mockServices = [
          const LabServiceModel(
            id: '1',
            name: 'Complete Blood Count (CBC)',
            price: 150.0,
            isHomeCollectionAvailable: true,
            turnaroundTime: '24 hours',
            category: 'Hematology',
          ),
          const LabServiceModel(
            id: '2',
            name: 'Complete Blood Count (CBC)',
            price: 140.0,
            isHomeCollectionAvailable: true,
            turnaroundTime: '24 hours',
            category: 'Hematology',
          ),
          const LabServiceModel(
            id: '3',
            name: 'Lipid Profile',
            price: 450.0,
            isHomeCollectionAvailable: false,
            turnaroundTime: '48 hours',
            category: 'Chemistry',
          ),
          const LabServiceModel(
            id: '4',
            name: 'Lipid Profile',
            price: 450.0,
            isHomeCollectionAvailable: false,
            turnaroundTime: '48 hours',
            category: 'Chemistry',
          ),
        ];
        totalActive = 142;
        homeVisits = 19;
      }

      emit(
        state.copyWith(
          status: LabServicesStatus.success,
          services: mockServices,
          totalActiveServices: totalActive,
          homeVisitsAvailableCount: homeVisits,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LabServicesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
