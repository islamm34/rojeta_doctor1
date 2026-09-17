import 'package:get_it/get_it.dart';

import '../data/datasources/home_visits_remote_data_source.dart';
import '../data/datasources/lab_home_remote_data_source.dart';
import '../data/datasources/lab_services_remote_data_source.dart';
import '../data/datasources/manage_branch_remote_data_source.dart';
import '../data/repositories/home_visits_repository_impl.dart';
import '../data/repositories/lab_home_repository_impl.dart';
import '../data/repositories/lab_services_repository_impl.dart';
import '../data/repositories/manage_branch_repository_impl.dart';
import '../domain/repositories/home_visits_repository.dart';
import '../domain/repositories/lab_home_repository.dart';
import '../domain/repositories/lab_services_repository.dart';
import '../domain/repositories/manage_branch_repository.dart';
import '../domain/usecases/add_lab_service_usecase.dart';
import '../domain/usecases/delete_lab_service_usecase.dart';
import '../domain/usecases/get_lab_dashboard_usecase.dart';
import '../domain/usecases/get_lab_services_usecase.dart';
import '../presentation/bloc/home_visits/home_visits_bloc.dart';
import '../presentation/bloc/lab_home_bloc.dart';
import '../presentation/bloc/manage_branch/manage_branch_bloc.dart';
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
  injector.registerLazySingleton<ManageBranchRemoteDataSource>(
    () => ManageBranchRemoteDataSourceImpl(apiConsumer: injector()),
  );
  injector.registerLazySingleton<HomeVisitsRemoteDataSource>(
    () => HomeVisitsRemoteDataSourceImpl(apiConsumer: injector()),
  );

  // Repositories
  injector.registerLazySingleton<LabHomeRepository>(
    () => LabHomeRepositoryImpl(remoteDataSource: injector()),
  );
  injector.registerLazySingleton<LabServicesRepository>(
    () => LabServicesRepositoryImpl(remoteDataSource: injector()),
  );
  injector.registerLazySingleton<ManageBranchRepository>(
    () => ManageBranchRepositoryImpl(remoteDataSource: injector()),
  );
  injector.registerLazySingleton<HomeVisitsRepository>(
    () => HomeVisitsRepositoryImpl(remoteDataSource: injector()),
  );

  // Use cases
  injector.registerLazySingleton(() => GetLabDashboardUseCase(injector()));
  injector.registerLazySingleton(() => GetLabServicesUseCase(injector()));
  injector.registerLazySingleton(() => AddLabServiceUseCase(injector()));
  injector.registerLazySingleton(() => DeleteLabServiceUseCase(injector()));

  // BLoCs
  injector.registerFactory(
    () => LabHomeBloc(getLabDashboardUseCase: injector()),
  );
  injector.registerFactory(
    () => LabServicesBloc(
      getLabServicesUseCase: injector(),
      addLabServiceUseCase: injector(),
      deleteLabServiceUseCase: injector(),
    ),
  );
  injector.registerFactory(
    () => ManageBranchBloc(repository: injector()),
  );
  injector.registerFactory(
    () => HomeVisitsBloc(repository: injector()),
  );
}
