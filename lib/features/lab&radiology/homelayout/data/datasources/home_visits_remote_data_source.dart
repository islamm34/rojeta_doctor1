import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../models/home_visit_config_model.dart';

abstract class HomeVisitsRemoteDataSource {
  Future<HomeVisitConfigModel> getHomeVisitsConfig({UserType? userType});
  Future<void> updateHomeVisitsConfig(HomeVisitConfigModel config, {UserType? userType});
}

class HomeVisitsRemoteDataSourceImpl implements HomeVisitsRemoteDataSource {
  final ApiConsumer apiConsumer;

  HomeVisitsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<HomeVisitConfigModel> getHomeVisitsConfig({UserType? userType}) async {
    final isRadiology = userType == UserType.radiologyCenter;
    final endpoints = isRadiology
        ? [Endpoints.getHomeVisitConfig, '/radiology/home-visits/config', '/radiology/home-visits', '/lab/home-visits/config']
        : [Endpoints.getHomeVisitConfig, '/lab/home-visits/config', '/lab/home-visits'];

    dynamic response;
    for (final ep in endpoints) {
      try {
        response = await apiConsumer.get(ep);
        if (response != null) break;
      } catch (_) {}
    }

    if (response is Map<String, dynamic>) {
      if (response['data'] is Map<String, dynamic>) {
        return HomeVisitConfigModel.fromJson(response['data'] as Map<String, dynamic>);
      }
      return HomeVisitConfigModel.fromJson(response);
    }

    return const HomeVisitConfigModel();
  }

  @override
  Future<void> updateHomeVisitsConfig(
    HomeVisitConfigModel config, {
    UserType? userType,
  }) async {
    final isRadiology = userType == UserType.radiologyCenter;
    final endpoints = isRadiology
        ? [
            Endpoints.getHomeVisitConfig,
            Endpoints.updateHomeVisitConfig,
            '/radiology/home-visits/config',
            '/radiology/home-visits',
            '/lab/home-visits/config',
          ]
        : [
            Endpoints.getHomeVisitConfig,
            Endpoints.updateHomeVisitConfig,
            '/lab/home-visits/config',
            '/lab/home-visits',
          ];

    for (final ep in endpoints) {
      try {
        await apiConsumer.put(ep, data: config.toJson());
        return;
      } catch (_) {
        try {
          await apiConsumer.post(ep, data: config.toJson());
          return;
        } catch (_) {
          try {
            await apiConsumer.patch(ep, data: config.toJson());
            return;
          } catch (_) {}
        }
      }
    }
  }
}
