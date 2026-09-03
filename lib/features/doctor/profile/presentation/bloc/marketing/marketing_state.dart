import 'package:equatable/equatable.dart';
import '../../../data/models/analytics_model.dart';
import '../../../data/models/marketing_package_model.dart';

enum MarketingStatus { initial, loading, success, failure }

class MarketingState extends Equatable {
  final MarketingStatus status;
  final List<MarketingPackageModel> packages;
  final ActivePlanModel? activePlan;
  final AnalyticsModel? analytics;
  final String? errorMessage;
  final String? subscriptionMessage;

  const MarketingState({
    this.status = MarketingStatus.initial,
    this.packages = const [],
    this.activePlan,
    this.analytics,
    this.errorMessage,
    this.subscriptionMessage,
  });

  MarketingState copyWith({
    MarketingStatus? status,
    List<MarketingPackageModel>? packages,
    ActivePlanModel? activePlan,
    AnalyticsModel? analytics,
    String? errorMessage,
    String? subscriptionMessage,
  }) {
    return MarketingState(
      status: status ?? this.status,
      packages: packages ?? this.packages,
      activePlan: activePlan ?? this.activePlan,
      analytics: analytics ?? this.analytics,
      errorMessage: errorMessage,
      subscriptionMessage: subscriptionMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        packages,
        activePlan,
        analytics,
        errorMessage,
        subscriptionMessage,
      ];
}
