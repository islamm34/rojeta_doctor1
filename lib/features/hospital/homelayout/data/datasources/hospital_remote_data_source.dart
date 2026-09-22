import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/hospital_dashboard_model.dart';

abstract class HospitalRemoteDataSource {
  Future<HospitalDashboardModel> getDashboardData();
}

class HospitalRemoteDataSourceImpl implements HospitalRemoteDataSource {
  final ApiConsumer apiConsumer;

  HospitalRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<HospitalDashboardModel> getDashboardData() async {
    try {
      final endpoints = [Endpoints.hospitalDashboard, '/hospital/dashboard'];

      for (final ep in endpoints) {
        try {
          final response = await apiConsumer.get(
            ep,
            queryParameters: {'user_type': 'hospital'},
          );
          if (response != null) {
            final data =
                response is Map<String, dynamic> && response['data'] != null
                ? (response['data'] is Map<String, dynamic>
                      ? response['data'] as Map<String, dynamic>
                      : response)
                : (response is Map<String, dynamic>
                      ? response
                      : <String, dynamic>{});
            return HospitalDashboardModel.fromJson(data);
          }
        } catch (_) {}
      }
    } catch (_) {}

    return const HospitalDashboardModel();
  }
}
