import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../models/create_lab_service_model.dart';
import '../models/lab_services_response_model.dart';

abstract class LabServicesRemoteDataSource {
  Future<LabServicesResponseModel> getServices({UserType? userType});
  Future<void> addService(CreateLabServiceModel service, {UserType? userType});
  Future<void> updateService(
    String id,
    CreateLabServiceModel service, {
    UserType? userType,
  });
  Future<void> deleteService(String id, {UserType? userType});
}

class LabServicesRemoteDataSourceImpl implements LabServicesRemoteDataSource {
  final ApiConsumer apiConsumer;

  LabServicesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<LabServicesResponseModel> getServices({UserType? userType}) async {
    final isRadiology = userType == UserType.radiologyCenter;
    final queryParams = <String, dynamic>{};
    if (userType != null) {
      queryParams['type'] = isRadiology ? 'radiology' : 'lab';
      queryParams['user_type'] = isRadiology ? 'radiology' : 'lab';
    }

    final endpointsToTry = isRadiology
        ? [Endpoints.labServices, '/radiology/services', '/radiology/scans', '/lab/services']
        : [Endpoints.labServices, '/lab/services', '/laboratory/tests'];

    dynamic response;
    for (final endpoint in endpointsToTry) {
      try {
        response = await apiConsumer.get(
          endpoint,
          queryParameters: queryParams.isNotEmpty ? queryParams : null,
        );
        if (response != null) break;
      } catch (_) {}
    }

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
  Future<void> addService(
    CreateLabServiceModel service, {
    UserType? userType,
  }) async {
    final isRadiology = userType == UserType.radiologyCenter;
    final primaryEndpoint =
        isRadiology ? Endpoints.labServices : Endpoints.labTests;
    final fallbackEndpoints = isRadiology
        ? [
            Endpoints.addLabService,
            '/radiology/services',
            '/radiology/scans',
            '/radiology/service/add',
            '/radiology/scan/add',
            '/lab/services',
          ]
        : [
            Endpoints.laboratoryAddTest,
            '/lab/services',
            '/laboratory/tests',
            '/lab/tests/add',
          ];

    try {
      await apiConsumer.post(primaryEndpoint, data: service.toJson());
    } catch (_) {
      bool succeeded = false;
      for (final endpoint in fallbackEndpoints) {
        try {
          await apiConsumer.post(endpoint, data: service.toJson());
          succeeded = true;
          break;
        } catch (_) {}
      }
      if (!succeeded) {
        rethrow;
      }
    }
  }

  @override
  Future<void> updateService(
    String id,
    CreateLabServiceModel service, {
    UserType? userType,
  }) async {
    final isRadiology = userType == UserType.radiologyCenter;
    final endpoints = isRadiology
        ? [Endpoints.labUpdateService(id), '/radiology/services/$id', '/radiology/scans/$id', '/lab/services/$id']
        : [Endpoints.labUpdateTest(id), '/lab/services/$id', '/laboratory/tests/$id'];

    for (final endpoint in endpoints) {
      try {
        await apiConsumer.put(endpoint, data: service.toJson());
        return;
      } catch (_) {
        try {
          await apiConsumer.post(endpoint, data: service.toJson());
          return;
        } catch (_) {
          try {
            await apiConsumer.patch(endpoint, data: service.toJson());
            return;
          } catch (_) {}
        }
      }
    }
  }

  @override
  Future<void> deleteService(String id, {UserType? userType}) async {
    final isRadiology = userType == UserType.radiologyCenter;
    final endpoints = isRadiology
        ? [Endpoints.labDeleteService(id), '/radiology/services/$id', '/radiology/scans/$id', '/lab/services/$id']
        : [Endpoints.labDeleteTest(id), '/lab/services/$id', '/laboratory/tests/$id'];

    for (final endpoint in endpoints) {
      try {
        await apiConsumer.delete(endpoint);
        return;
      } catch (_) {}
    }
  }
}
