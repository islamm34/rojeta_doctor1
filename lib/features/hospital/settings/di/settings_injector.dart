import 'package:get_it/get_it.dart';
import '../data/datasources/settings_local_data_source.dart';
import '../data/repositories/settings_repository_impl.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/usecases/get_settings_usecase.dart';
import '../domain/usecases/update_settings_usecase.dart';
import '../presentation/bloc/settings_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final injector = GetIt.instance;

Future<void> initSettingsInjector() async {
  // Data sources
  injector.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(secureStorage: injector<FlutterSecureStorage>()),
  );

  // Repositories
  injector.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: injector()),
  );

  // Use cases
  injector.registerLazySingleton(
    () => GetSettingsUseCase(injector()),
  );
  injector.registerLazySingleton(
    () => UpdateSettingsUseCase(injector()),
  );

  // BLoC
  injector.registerFactory(
    () => SettingsBloc(
      getSettingsUseCase: injector(),
      updateSettingsUseCase: injector(),
    ),
  );
}
