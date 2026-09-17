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
    final response = await apiConsumer.get(Endpoints.getHomeVisitConfig);

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
    await apiConsumer.post(
      Endpoints.updateHomeVisitConfig,
      data: config.toJson(),
    );
  }
}
