import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/error/exceptions.dart';
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
      final results = await Future.wait([
        repository.getPackages(),
        repository.getActivePlan(),
        repository.getAnalytics(),
      ]);

      emit(state.copyWith(
        status: MarketingStatus.success,
        packages: results[0] as dynamic,
        activePlan: results[1] as dynamic,
        analytics: results[2] as dynamic,
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
      final subId = await repository.subscribeToPackage(
        packageId: event.packageId,
        billingCycle: event.billingCycle,
      );
      // Refresh active plan
      final activePlan = await repository.getActivePlan();
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
