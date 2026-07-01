import '../../../core/di/injector.dart';
import '../data/datasources/local/auth_local_data_source_impl.dart';
import '../data/datasources/remote/auth_remote_data_source_impl.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/get_auth.dart';
import '../presentation/bloc/auth_bloc.dart';
import '../../auth/domain/datasources/auth_local_data_source.dart' as local_ds;
import '../../auth/domain/datasources/auth_remote_data_source.dart' as remote_ds;

Future<void> initAuthInjector() async {
  // BLoC
  injector.registerFactory(() => AuthBloc(
        getAuth: injector(),
      ));

  // UseCases
  injector.registerLazySingleton(() => GetAuthUseCase(injector()));

  // Repositories
  injector.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remote: injector(),
        local: injector(),
      ));

  // DataSources
  // Register implementations for the interfaces
  injector.registerLazySingleton<remote_ds.AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  injector.registerLazySingleton<local_ds.AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());
}
