import 'package:get_it/get_it.dart';

import '../data/datasources/lab_home_remote_data_source.dart';
import '../data/datasources/lab_services_remote_data_source.dart';
import '../data/repositories/lab_home_repository_impl.dart';
import '../data/repositories/lab_services_repository_impl.dart';
import '../domain/repositories/lab_home_repository.dart';
import '../domain/repositories/lab_services_repository.dart';
import '../domain/usecases/delete_lab_service_usecase.dart';
import '../domain/usecases/get_lab_dashboard_usecase.dart';
import '../domain/usecases/get_lab_services_usecase.dart';
import '../presentation/bloc/lab_home_bloc.dart';
import '../presentation/bloc/services/lab_services_bloc.dart';

final injector = GetIt.instance;

Future<void> initLabHomeLayoutInjector() async {
  // Data sources
  injector.registerLazySingleton<LabHomeRemoteDataSource>(
    () => LabHomeRemoteDataSourceImpl(apiConsumer: injector()),
  );
  injector.registerLazySingleton<LabServicesRemoteDataSource>(
    () => LabServicesRemoteDataSourceImpl(apiConsumer: injector()),
  );

  // Repositories
  injector.registerLazySingleton<LabHomeRepository>(
    () => LabHomeRepositoryImpl(remoteDataSource: injector()),
  );
  injector.registerLazySingleton<LabServicesRepository>(
    () => LabServicesRepositoryImpl(remoteDataSource: injector()),
  );

  // Use cases
  injector.registerLazySingleton(() => GetLabDashboardUseCase(injector()));
  injector.registerLazySingleton(() => GetLabServicesUseCase(injector()));
  injector.registerLazySingleton(() => DeleteLabServiceUseCase(injector()));

  // BLoCs
  injector.registerFactory(
    () => LabHomeBloc(getLabDashboardUseCase: injector()),
  );
  injector.registerFactory(
    () => LabServicesBloc(
      getLabServicesUseCase: injector(),
      deleteLabServiceUseCase: injector(),
    ),
  );
}
