import 'package:get_it/get_it.dart';
import '../data/datasources/settings_remote_data_source.dart';
import '../data/repositories/settings_repository_impl.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/usecases/get_settings_data_usecase.dart';
import '../domain/usecases/update_general_settings_usecase.dart';
import '../presentation/bloc/settings_bloc.dart';

final injector = GetIt.instance;

void initSettingsDI() {
  // Bloc
  injector.registerFactory(() => SettingsBloc(
        getSettingsDataUseCase: injector(),
        updateGeneralSettingsUseCase: injector(),
      ));

  // UseCases
  injector.registerLazySingleton(() => GetSettingsDataUseCase(injector()));
  injector.registerLazySingleton(() => UpdateGeneralSettingsUseCase(injector()));

  // Repository
  injector.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(remoteDataSource: injector()));

  // Data Sources
  injector.registerLazySingleton<SettingsRemoteDataSource>(
      () => SettingsRemoteDataSourceImpl(apiConsumer: injector()));
}
