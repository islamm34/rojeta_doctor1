import '../../../../core/di/injector.dart';
import '../../../../core/network/api_consumer.dart';
import '../data/datasources/nursing_remote_data_source.dart';
import '../data/repositories/nursing_repository_impl.dart';
import '../domain/repositories/i_nursing_repository.dart';
import '../presentation/bloc/nursing_bloc.dart';

Future<void> initNursingInjector() async {
  // Remote Data Source
  injector.registerLazySingleton<NursingRemoteDataSource>(
    () => NursingRemoteDataSourceImpl(apiConsumer: injector<ApiConsumer>()),
  );

  // Repository
  injector.registerLazySingleton<INursingRepository>(
    () => NursingRepositoryImpl(remoteDataSource: injector<NursingRemoteDataSource>()),
  );

  // BLoC
  injector.registerFactory<NursingBloc>(
    () => NursingBloc(repository: injector<INursingRepository>()),
  );
}
