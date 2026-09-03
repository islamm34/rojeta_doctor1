import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/analytics_model.dart';
import '../models/marketing_package_model.dart';

abstract class MarketingRemoteDataSource {
  Future<List<MarketingPackageModel>> getPackages();
  Future<ActivePlanModel?> getActivePlan();
  Future<String> subscribeToPackage({
    required String packageId,
    required String billingCycle,
  });
  Future<AnalyticsModel> getAnalytics({String? month});
}

class MarketingRemoteDataSourceImpl implements MarketingRemoteDataSource {
  final ApiConsumer apiConsumer;

  MarketingRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<MarketingPackageModel>> getPackages() async {
    final response = await apiConsumer.get(Endpoints.doctorMarketingPackages);
    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});

    final packagesList = data['packages'] as List<dynamic>? ?? [];
    return packagesList
        .whereType<Map<String, dynamic>>()
        .map((e) => MarketingPackageModel.fromJson(e))
        .toList();
  }

  @override
  Future<ActivePlanModel?> getActivePlan() async {
    final response = await apiConsumer.get(Endpoints.doctorMarketingPackages);
    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});

    if (data['activePlan'] != null && data['activePlan'] is Map<String, dynamic>) {
      return ActivePlanModel.fromJson(
        data['activePlan'] as Map<String, dynamic>,
      );
    }
    return null;
  }

  @override
  Future<String> subscribeToPackage({
    required String packageId,
    required String billingCycle,
  }) async {
    final response = await apiConsumer.post(
      Endpoints.doctorMarketingSubscribe,
      data: {
        'packageId': int.tryParse(packageId) ?? packageId,
        'billingCycle': billingCycle,
      },
    );
    if (response is Map && response['data'] is Map) {
      return response['data']['subscriptionId']?.toString() ?? '';
    }
    return '';
  }

  @override
  Future<AnalyticsModel> getAnalytics({String? month}) async {
    final query = <String, dynamic>{};
    if (month != null && month.isNotEmpty) query['month'] = month;

    final response = await apiConsumer.get(
      Endpoints.doctorAnalytics,
      queryParameters: query.isNotEmpty ? query : null,
    );

    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});

    return AnalyticsModel.fromJson(data);
  }
}
