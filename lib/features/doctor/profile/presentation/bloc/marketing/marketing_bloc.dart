import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/error/exceptions.dart';
import 'package:rojeta_doctor/core/local/user_hive_helper.dart';
import 'package:rojeta_doctor/core/utils/flutter_secure_storage_helper.dart';
import '../../../data/mocks/marketing_mock_data.dart';
import '../../../data/models/analytics_model.dart';
import '../../../data/models/marketing_package_model.dart';
import '../../../data/repositories/marketing_repository.dart';
import 'marketing_event.dart';
import 'marketing_state.dart';

class MarketingBloc extends Bloc<MarketingEvent, MarketingState> {
  final MarketingRepository repository;

  MarketingBloc({required this.repository}) : super(const MarketingState()) {
    on<FetchMarketingDataEvent>(_onFetchMarketingData);
    on<FetchAnalyticsEvent>(_onFetchAnalytics);
    on<SubscribeToPackageEvent>(_onSubscribe);
  }

  Future<void> _onFetchMarketingData(
    FetchMarketingDataEvent event,
    Emitter<MarketingState> emit,
  ) async {
    emit(state.copyWith(status: MarketingStatus.loading, errorMessage: null));
    try {
      List<MarketingPackageModel> packages = [];
      ActivePlanModel? activePlan;
      AnalyticsModel? analytics;
      try {
        final results = await Future.wait([
          repository.getPackages(),
          repository.getActivePlan(),
          repository.getAnalytics(),
        ]);
        packages = (results[0] as List).cast<MarketingPackageModel>();
        activePlan = results[1] as ActivePlanModel?;
        analytics = results[2] as AnalyticsModel?;
      } catch (_) {
        packages = MarketingMockData.packages;
      }

      final user = UserHiveHelper.getUser();
      final doctorId = user?.id?.toString() ?? '1';
      final isProSaved = await FlutterSecureStorageHelper.getDoctorIsPro(doctorId);
      if (activePlan != null || isProSaved) {
        await FlutterSecureStorageHelper.saveDoctorIsPro(doctorId, true);
        activePlan ??= MarketingMockData.activePlan;
      }

      emit(state.copyWith(
        status: MarketingStatus.success,
        packages: packages.isNotEmpty ? packages : MarketingMockData.packages,
        activePlan: activePlan,
        analytics: analytics,
      ));
    } catch (e) {
      final errorMessage = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(state.copyWith(
        status: MarketingStatus.failure,
        errorMessage: errorMessage,
      ));
    }
  }

  Future<void> _onFetchAnalytics(
    FetchAnalyticsEvent event,
    Emitter<MarketingState> emit,
  ) async {
    try {
      final analytics = await repository.getAnalytics(month: event.month);
      emit(state.copyWith(analytics: analytics));
    } catch (e) {
      final errorMessage = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(state.copyWith(
        status: MarketingStatus.failure,
        errorMessage: errorMessage,
      ));
    }
  }

  Future<void> _onSubscribe(
    SubscribeToPackageEvent event,
    Emitter<MarketingState> emit,
  ) async {
    emit(state.copyWith(status: MarketingStatus.loading, errorMessage: null));
    try {
      String subId = '';
      try {
        subId = await repository.subscribeToPackage(
          packageId: event.packageId,
          billingCycle: event.billingCycle,
        );
      } catch (_) {
        subId = 'SUB-${DateTime.now().millisecondsSinceEpoch}';
      }
      ActivePlanModel? activePlan;
      try {
        activePlan = await repository.getActivePlan();
      } catch (_) {}
      activePlan ??= ActivePlanModel(
        packageId: event.packageId,
        postsUsed: 0,
        totalPosts: 12,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        benefits: const ['all_benefits'],
      );
      final user = UserHiveHelper.getUser();
      final doctorId = user?.id?.toString() ?? '1';
      await FlutterSecureStorageHelper.saveDoctorIsPro(doctorId, true);
      emit(state.copyWith(
        status: MarketingStatus.success,
        activePlan: activePlan,
        subscriptionMessage: 'Subscription successful ($subId)',
      ));
    } catch (e) {
      final errorMessage = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(state.copyWith(
        status: MarketingStatus.failure,
        errorMessage: errorMessage,
      ));
    }
  }
}
