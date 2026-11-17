import 'package:equatable/equatable.dart';
import '../../../data/models/doctor_appointment_model.dart';

enum DoctorAppointmentsStatus { initial, loading, success, failure }

class DoctorAppointmentsState extends Equatable {
  final DoctorAppointmentsStatus status;
  final List<DoctorAppointmentModel> appointments;
  final String
  selectedFilter; // 'All', 'Pending', 'Confirmed', 'Completed', 'Cancelled'
  final String? errorMessage;
  final bool isUpdatingStatus;

  const DoctorAppointmentsState({
    this.status = DoctorAppointmentsStatus.initial,
    this.appointments = const [],
    this.selectedFilter = 'All',
    this.errorMessage,
    this.isUpdatingStatus = false,
  });

  List<DoctorAppointmentModel> get filteredAppointments {
    if (selectedFilter.toLowerCase() == 'all') return appointments;
    final target = DoctorAppointmentModel.normalizeStatus(
      selectedFilter,
    ).toLowerCase();
    return appointments.where((a) {
      final itemStatus = DoctorAppointmentModel.normalizeStatus(
        a.status,
      ).toLowerCase();
      return itemStatus == target;
    }).toList();
  }

  DoctorAppointmentsState copyWith({
    DoctorAppointmentsStatus? status,
    List<DoctorAppointmentModel>? appointments,
    String? selectedFilter,
    String? errorMessage,
    bool? isUpdatingStatus,
  }) {
    return DoctorAppointmentsState(
      status: status ?? this.status,
      appointments: appointments ?? this.appointments,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      errorMessage: errorMessage,
      isUpdatingStatus: isUpdatingStatus ?? this.isUpdatingStatus,
    );
  }

  @override
  List<Object?> get props => [
    status,
    appointments,
    selectedFilter,
    errorMessage,
    isUpdatingStatus,
  ];
}
