import 'package:equatable/equatable.dart';
import '../../../data/models/home_visit_config_model.dart';

enum HomeVisitsStatus { initial, loading, success, failure, saving, saveSuccess }

class HomeVisitsState extends Equatable {
  final HomeVisitsStatus status;
  final HomeVisitConfigModel config;
  final String? errorMessage;

  const HomeVisitsState({
    this.status = HomeVisitsStatus.initial,
    this.config = const HomeVisitConfigModel(),
    this.errorMessage,
  });

  HomeVisitsState copyWith({
    HomeVisitsStatus? status,
    HomeVisitConfigModel? config,
    String? errorMessage,
  }) {
    return HomeVisitsState(
      status: status ?? this.status,
      config: config ?? this.config,
      errorMessage: errorMessage,
    );
  }

  HomeVisitsState copyWithClearError({
    HomeVisitsStatus? status,
    HomeVisitConfigModel? config,
  }) {
    return HomeVisitsState(
      status: status ?? this.status,
      config: config ?? this.config,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, config, errorMessage];
}
