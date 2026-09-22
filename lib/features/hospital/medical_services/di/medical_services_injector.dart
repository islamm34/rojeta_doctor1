import '../../../../core/di/injector.dart';
import '../../../../core/network/api_consumer.dart';
import '../data/datasources/medical_services_remote_data_source.dart';
import '../data/repositories/medical_services_repository_impl.dart';
import '../domain/repositories/i_medical_services_repository.dart';
import '../presentation/bloc/medical_services_bloc.dart';

Future<void> initMedicalServicesInjector() async {
  // Remote Data Source
  injector.registerLazySingleton<MedicalServicesRemoteDataSource>(
    () => MedicalServicesRemoteDataSourceImpl(
      apiConsumer: injector<ApiConsumer>(),
    ),
  );

  // Repository
  injector.registerLazySingleton<IMedicalServicesRepository>(
    () => MedicalServicesRepositoryImpl(
      remoteDataSource: injector<MedicalServicesRemoteDataSource>(),
    ),
  );

  // Blocs
  injector.registerLazySingleton<MedicalServicesBloc>(
    () =>
        MedicalServicesBloc(repository: injector<IMedicalServicesRepository>()),
  );
}
