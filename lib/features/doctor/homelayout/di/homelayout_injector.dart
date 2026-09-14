import '../../../../core/di/injector.dart';
import '../../../../core/network/api_consumer.dart';
import '../data/datasources/local/homelayout_local_data_source_impl.dart';
import '../data/datasources/remote/doctor_appointments_remote_data_source.dart';
import '../data/datasources/remote/doctor_dashboard_remote_data_source.dart';
import '../data/datasources/remote/doctor_notifications_remote_data_source.dart';
import '../data/datasources/remote/homelayout_remote_data_source_impl.dart';
import '../data/repositories/doctor_appointments_repository.dart';
import '../data/repositories/doctor_dashboard_repository.dart';
import '../data/repositories/doctor_notifications_repository.dart';
import '../data/repositories/homelayout_repository_impl.dart';
import '../data/repositories/medical_consultation_repository.dart';
import '../data/repositories/patients_repository.dart';
import '../data/repositories/schedule_repository.dart';
import '../domain/datasources/homelayout_local_data_source.dart' as local_ds;
import '../domain/datasources/homelayout_remote_data_source.dart' as remote_ds;
import '../domain/repositories/homelayout_repository.dart';
import '../domain/usecases/get_homelayout.dart';
import '../presentation/bloc/appointment_details/appointment_details_bloc.dart';
import '../presentation/bloc/appointments/doctor_appointments_bloc.dart';
import '../presentation/bloc/homelayout_bloc.dart';
import '../presentation/bloc/medical_consultation/medical_consultation_bloc.dart';
import '../presentation/bloc/notifications/notifications_cubit.dart';
import '../presentation/bloc/patients/patients_bloc.dart';
import '../presentation/bloc/schedule/schedule_bloc.dart';

Future<void> initHomelayoutInjector() async {
  // DataSources
  injector.registerLazySingleton<DoctorDashboardRemoteDataSource>(
    () => DoctorDashboardRemoteDataSourceImpl(
      apiConsumer: injector<ApiConsumer>(),
    ),
  );
  injector.registerLazySingleton<DoctorAppointmentsRemoteDataSource>(
    () => DoctorAppointmentsRemoteDataSourceImpl(
      apiConsumer: injector<ApiConsumer>(),
    ),
  );
  injector.registerLazySingleton<DoctorNotificationsRemoteDataSource>(
    () => DoctorNotificationsRemoteDataSourceImpl(
      apiConsumer: injector<ApiConsumer>(),
    ),
  );
  injector.registerLazySingleton<remote_ds.HomelayoutRemoteDataSource>(
    () => HomelayoutRemoteDataSourceImpl(),
  );
  injector.registerLazySingleton<local_ds.HomelayoutLocalDataSource>(
    () => HomelayoutLocalDataSourceImpl(),
  );

  // Repositories
  injector.registerLazySingleton<DoctorDashboardRepository>(
    () => DoctorDashboardRepositoryImpl(remoteDataSource: injector()),
  );
  injector.registerLazySingleton<DoctorAppointmentsRepository>(
    () => DoctorAppointmentsRepositoryImpl(remoteDataSource: injector()),
  );
  injector.registerLazySingleton<DoctorNotificationsRepository>(
    () => DoctorNotificationsRepositoryImpl(remoteDataSource: injector()),
  );
  injector.registerLazySingleton<HomelayoutRepository>(
    () => HomelayoutRepositoryImpl(remote: injector(), local: injector()),
  );
  injector.registerLazySingleton(
    () => PatientsRepository(apiConsumer: injector<ApiConsumer>()),
  );
  injector.registerLazySingleton<MedicalConsultationRepository>(
    () => MedicalConsultationRepository(injector<ApiConsumer>()),
  );
  injector.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepository(injector<ApiConsumer>()),
  );

  // UseCases
  injector.registerLazySingleton(() => GetHomelayoutUseCase(injector()));

  // BLoCs & Cubits
  injector.registerFactory(
    () => HomelayoutBloc(
      dashboardRepository: injector(),
      appointmentsRepository: injector(),
    ),
  );
  injector.registerFactory(
    () => DoctorAppointmentsBloc(repository: injector()),
  );
  injector.registerFactory(
    () => AppointmentDetailsBloc(repository: injector()),
  );
  injector.registerFactory(() => NotificationsCubit(repository: injector()));
  injector.registerFactory(() => PatientsBloc(injector()));
  injector.registerFactory<MedicalConsultationBloc>(
    () => MedicalConsultationBloc(injector()),
  );
  injector.registerFactory<ScheduleBloc>(() => ScheduleBloc(injector()));
}
