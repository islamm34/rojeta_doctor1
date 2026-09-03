import '../datasources/remote/doctor_dashboard_remote_data_source.dart';
import '../models/doctor_dashboard_stats.dart';
import '../models/doctor_profile_model.dart';

abstract class DoctorDashboardRepository {
  Future<DoctorDashboardStats> getDashboardStats();
  Future<DoctorProfileModel> getProfileSummary();
}

class DoctorDashboardRepositoryImpl implements DoctorDashboardRepository {
  final DoctorDashboardRemoteDataSource remoteDataSource;

  DoctorDashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DoctorDashboardStats> getDashboardStats() =>
      remoteDataSource.getDashboardStats();

  @override
  Future<DoctorProfileModel> getProfileSummary() =>
      remoteDataSource.getProfileSummary();
}
