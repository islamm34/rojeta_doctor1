import '../../../../core/di/injector.dart';
import '../data/datasources/profile_remote_data_source.dart';
import '../data/datasources/profile_remote_data_source_impl.dart';
import '../data/repositories/profile_repository_impl.dart';
import '../domain/repositories/profile_repository.dart';
import '../domain/usecases/get_profile_use_case.dart';
import '../presentation/bloc/profile/profile_bloc.dart';

Future<void> initDoctorProfileInjector() async {
  // BLoC
  injector.registerFactory(() => ProfileBloc(
        getProfileUseCase: injector(),
      ));

  // UseCases
  injector.registerLazySingleton(() => GetProfileUseCase(injector()));

  // Repositories
  injector.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: injector()),
  );

  // DataSources
  injector.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiConsumer: injector()),
  );
}
