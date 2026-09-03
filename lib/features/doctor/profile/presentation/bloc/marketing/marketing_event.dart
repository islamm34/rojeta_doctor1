import 'package:equatable/equatable.dart';

abstract class MarketingEvent extends Equatable {
  const MarketingEvent();

  @override
  List<Object?> get props => [];
}

class FetchMarketingDataEvent extends MarketingEvent {
  const FetchMarketingDataEvent();
}

class FetchAnalyticsEvent extends MarketingEvent {
  final String? month;

  const FetchAnalyticsEvent({this.month});

  @override
  List<Object?> get props => [month];
}

class SubscribeToPackageEvent extends MarketingEvent {
  final String packageId;
  final String billingCycle;

  const SubscribeToPackageEvent({
    required this.packageId,
    required this.billingCycle,
  });

  @override
  List<Object?> get props => [packageId, billingCycle];
}
