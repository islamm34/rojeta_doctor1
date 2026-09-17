import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../models/lab_services_response_model.dart';

abstract class LabServicesRemoteDataSource {
  Future<LabServicesResponseModel> getServices({UserType? userType});
  Future<void> deleteService(String id, {UserType? userType});
}

class LabServicesRemoteDataSourceImpl implements LabServicesRemoteDataSource {
  final ApiConsumer apiConsumer;

  LabServicesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<LabServicesResponseModel> getServices({UserType? userType}) async {
    final queryParams = <String, dynamic>{};
    if (userType != null) {
      queryParams['type'] = userType == UserType.radiologyCenter
          ? 'radiology'
          : 'lab';
    }

    final response = await apiConsumer.get(
      Endpoints.labServices,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );

    if (response is List) {
      return LabServicesResponseModel.fromList(response);
    } else if (response is Map<String, dynamic>) {
      if (response['data'] is List) {
        return LabServicesResponseModel.fromList(
          response['data'] as List<dynamic>,
        );
      }
      return LabServicesResponseModel.fromJson(response);
    }

    return const LabServicesResponseModel(
      services: [],
      totalActiveServices: 0,
      homeVisitsAvailableCount: 0,
    );
  }

  @override
  Future<void> deleteService(String id, {UserType? userType}) async {
    await apiConsumer.delete(Endpoints.labDeleteService(id));
  }
}
