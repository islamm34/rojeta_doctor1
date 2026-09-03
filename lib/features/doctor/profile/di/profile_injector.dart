import '../../../../core/di/injector.dart';
import '../data/datasources/marketing_remote_data_source.dart';
import '../data/datasources/profile_remote_data_source.dart';
import '../data/datasources/profile_remote_data_source_impl.dart';
import '../data/repositories/marketing_repository.dart';
import '../data/repositories/profile_repository_impl.dart';
import '../domain/repositories/profile_repository.dart';
import '../domain/usecases/get_profile_use_case.dart';
import '../presentation/bloc/marketing/marketing_bloc.dart';
import '../presentation/bloc/profile/profile_bloc.dart';

Future<void> initDoctorProfileInjector() async {
  // DataSources
  injector.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiConsumer: injector()),
  );
  injector.registerLazySingleton<MarketingRemoteDataSource>(
    () => MarketingRemoteDataSourceImpl(apiConsumer: injector()),
  );

  // Repositories
  injector.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: injector()),
  );
  injector.registerLazySingleton<MarketingRepository>(
    () => MarketingRepositoryImpl(remoteDataSource: injector()),
  );

  // UseCases
  injector.registerLazySingleton(() => GetProfileUseCase(injector()));

  // BLoCs
  injector.registerFactory(
    () => ProfileBloc(
      getProfileUseCase: injector(),
      profileRepository: injector(),
    ),
  );
  injector.registerFactory(
    () => MarketingBloc(repository: injector()),
  );
}
