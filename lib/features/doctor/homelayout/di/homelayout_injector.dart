import '../../../../core/di/injector.dart';
import '../data/datasources/local/homelayout_local_data_source_impl.dart';
import '../data/datasources/remote/homelayout_remote_data_source_impl.dart';
import '../data/repositories/homelayout_repository_impl.dart';
import '../domain/repositories/homelayout_repository.dart';
import '../domain/usecases/get_homelayout.dart';
import '../presentation/bloc/homelayout_bloc.dart';
import '../domain/datasources/homelayout_local_data_source.dart' as local_ds;
import '../domain/datasources/homelayout_remote_data_source.dart' as remote_ds;
import '../data/repositories/patients_repository.dart';
import '../presentation/bloc/patients/patients_bloc.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_client.dart';
import '../data/repositories/medical_consultation_repository.dart';
import '../presentation/bloc/medical_consultation/medical_consultation_bloc.dart';
import '../data/repositories/schedule_repository.dart';
import '../presentation/bloc/schedule/schedule_bloc.dart';

Future<void> initHomelayoutInjector() async {
  // BLoC
  injector.registerFactory(() => HomelayoutBloc(
        getHomelayout: injector(),
      ));
  injector.registerFactory(() => PatientsBloc(injector()));
  injector.registerFactory<MedicalConsultationBloc>(
    () => MedicalConsultationBloc(injector()),
  );
  injector.registerFactory<ScheduleBloc>(
    () => ScheduleBloc(injector()),
  );

  // UseCases
  injector.registerLazySingleton(() => GetHomelayoutUseCase(injector()));

  // Repositories
  injector.registerLazySingleton<HomelayoutRepository>(() => HomelayoutRepositoryImpl(
        remote: injector(),
        local: injector(),
      ));
  injector.registerLazySingleton(() => PatientsRepository());
  injector.registerLazySingleton<MedicalConsultationRepository>(
    () => MedicalConsultationRepository(injector<ApiConsumer>() as DioClient),
  );
  injector.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepository(injector<ApiConsumer>() as DioClient),
  );

  // DataSources
  // Register implementations for the interfaces
  injector.registerLazySingleton<remote_ds.HomelayoutRemoteDataSource>(
      () => HomelayoutRemoteDataSourceImpl());
  injector.registerLazySingleton<local_ds.HomelayoutLocalDataSource>(
      () => HomelayoutLocalDataSourceImpl());
}
