import '../datasources/marketing_remote_data_source.dart';
import '../models/analytics_model.dart';
import '../models/marketing_package_model.dart';

abstract class MarketingRepository {
  Future<List<MarketingPackageModel>> getPackages();
  Future<ActivePlanModel?> getActivePlan();
  Future<String> subscribeToPackage({
    required String packageId,
    required String billingCycle,
  });
  Future<AnalyticsModel> getAnalytics({String? month});
}

class MarketingRepositoryImpl implements MarketingRepository {
  final MarketingRemoteDataSource remoteDataSource;

  MarketingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MarketingPackageModel>> getPackages() =>
      remoteDataSource.getPackages();

  @override
  Future<ActivePlanModel?> getActivePlan() =>
      remoteDataSource.getActivePlan();

  @override
  Future<String> subscribeToPackage({
    required String packageId,
    required String billingCycle,
  }) =>
      remoteDataSource.subscribeToPackage(
        packageId: packageId,
        billingCycle: billingCycle,
      );

  @override
  Future<AnalyticsModel> getAnalytics({String? month}) =>
      remoteDataSource.getAnalytics(month: month);
}
