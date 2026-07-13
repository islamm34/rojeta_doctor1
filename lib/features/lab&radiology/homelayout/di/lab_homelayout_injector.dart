import 'package:get_it/get_it.dart';
import '../data/datasources/lab_home_local_datasource.dart';
import '../data/repositories/lab_home_repository_impl.dart';
import '../domain/repositories/lab_home_repository.dart';
import '../domain/usecases/get_lab_dashboard_usecase.dart';
import '../presentation/bloc/lab_home_bloc.dart';
import '../presentation/bloc/services/lab_services_bloc.dart';

final injector = GetIt.instance;

Future<void> initLabHomeLayoutInjector() async {
  // Data sources
  injector.registerLazySingleton<LabHomeLocalDataSource>(
    () => LabHomeLocalDataSourceImpl(),
  );

  // Repositories
  injector.registerLazySingleton<LabHomeRepository>(
    () => LabHomeRepositoryImpl(localDataSource: injector()),
  );

  // Use cases
  injector.registerLazySingleton(
    () => GetLabDashboardUseCase(injector()),
  );

  // BLoC
  injector.registerFactory(
    () => LabHomeBloc(getLabDashboardUseCase: injector()),
  );
  injector.registerFactory(
    () => LabServicesBloc(),
  );
}
