import '../models/hospital_stats_model.dart';
import '../../../../doctor/homelayout/data/models/doctor_appointment_model.dart';

class HospitalMockData {
  static const HospitalStatsModel stats = HospitalStatsModel(
    doctors: '48',
    todaysIncome: '12,500 EGP',
    appointments: '124',
  );

  static final List<DoctorAppointmentModel> upcomingAppointments = [
    DoctorAppointmentModel(
      id: '1',
      patientName: 'Orthopedic Clinic',
      patientAge: '30',
      patientGender: 'Male',
      appointmentDate: '2023-11-20',
      appointmentTime: '10:00 AM',
      type: 'Dr. Ahmed Hassan', // Using type parameter here for displaying doctor
      status: 'scheduled',
      isOnline: false,
    ),
    DoctorAppointmentModel(
      id: '2',
      patientName: 'Pediatric Clinic',
      patientAge: '5',
      patientGender: 'Female',
      appointmentDate: '2023-11-20',
      appointmentTime: '11:30 AM',
      type: 'Dr. Sarah Smith',
      status: 'scheduled',
      isOnline: false,
    ),
  ];
}
