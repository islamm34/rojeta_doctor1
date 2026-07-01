import '../../../core/di/injector.dart';
import '../data/datasources/local/homelayout_local_data_source_impl.dart';
import '../data/datasources/remote/homelayout_remote_data_source_impl.dart';
import '../data/repositories/homelayout_repository_impl.dart';
import '../domain/repositories/homelayout_repository.dart';
import '../domain/usecases/get_homelayout.dart';
import '../presentation/bloc/homelayout_bloc.dart';
import '../../homelayout/domain/datasources/homelayout_local_data_source.dart' as local_ds;
import '../../homelayout/domain/datasources/homelayout_remote_data_source.dart' as remote_ds;

Future<void> initHomelayoutInjector() async {
  // BLoC
  injector.registerFactory(() => HomelayoutBloc(
        getHomelayout: injector(),
      ));

  // UseCases
  injector.registerLazySingleton(() => GetHomelayoutUseCase(injector()));

  // Repositories
  injector.registerLazySingleton<HomelayoutRepository>(() => HomelayoutRepositoryImpl(
        remote: injector(),
        local: injector(),
      ));

  // DataSources
  // Register implementations for the interfaces
  injector.registerLazySingleton<remote_ds.HomelayoutRemoteDataSource>(
      () => HomelayoutRemoteDataSourceImpl());
  injector.registerLazySingleton<local_ds.HomelayoutLocalDataSource>(
      () => HomelayoutLocalDataSourceImpl());
}
