import '../../../../core/di/injector.dart';
import '../../../../core/network/api_consumer.dart';
import '../data/datasources/hospital_remote_data_source.dart';
import '../data/repositories/hospital_repository_impl.dart';
import '../domain/repositories/i_hospital_repository.dart';
import '../presentation/bloc/hospital_bloc.dart';

Future<void> initHospitalInjector() async {
  // Remote Data Source
  injector.registerLazySingleton<HospitalRemoteDataSource>(
    () => HospitalRemoteDataSourceImpl(apiConsumer: injector<ApiConsumer>()),
  );

  // Repository
  injector.registerLazySingleton<IHospitalRepository>(
    () => HospitalRepositoryImpl(
      remoteDataSource: injector<HospitalRemoteDataSource>(),
    ),
  );

  // BLoC
  injector.registerFactory<HospitalBloc>(
    () => HospitalBloc(repository: injector<IHospitalRepository>()),
  );
}
