import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../models/lab_home_model.dart';

abstract class LabHomeRemoteDataSource {
  Future<LabHomeModel> getDashboardData({UserType? userType});
}

class LabHomeRemoteDataSourceImpl implements LabHomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  LabHomeRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<LabHomeModel> getDashboardData({UserType? userType}) async {
    final queryParams = <String, dynamic>{};
    if (userType != null) {
      queryParams['user_type'] = userType == UserType.radiologyCenter
          ? 'radiology'
          : 'lab';
    }

    final response = await apiConsumer.get(
      Endpoints.labDashboard,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );

    final data = response is Map<String, dynamic> && response['data'] != null
        ? (response['data'] is Map<String, dynamic>
              ? response['data'] as Map<String, dynamic>
              : response)
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});

    return LabHomeModel.fromJson(data);
  }
}
