import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../models/doctor_dashboard_stats.dart';
import '../../models/doctor_profile_model.dart';

abstract class DoctorDashboardRemoteDataSource {
  Future<DoctorDashboardStats> getDashboardStats();
  Future<DoctorProfileModel> getProfileSummary();
}

class DoctorDashboardRemoteDataSourceImpl
    implements DoctorDashboardRemoteDataSource {
  final ApiConsumer apiConsumer;

  DoctorDashboardRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<DoctorDashboardStats> getDashboardStats() async {
    final response = await apiConsumer.get(Endpoints.doctorDashboard);
    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});
    return DoctorDashboardStats.fromJson(data);
  }

  @override
  Future<DoctorProfileModel> getProfileSummary() async {
    final response = await apiConsumer.get(Endpoints.doctorProfileSummary);
    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});
    return DoctorProfileModel.fromJson(data);
  }
}
