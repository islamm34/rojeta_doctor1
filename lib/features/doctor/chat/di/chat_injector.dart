import '../../../../core/di/injector.dart';
import '../data/datasources/doctor_chat_remote_data_source.dart';
import '../data/repositories/doctor_chat_repository.dart';
import '../presentation/bloc/doctor_chat_bloc.dart';

Future<void> initDoctorChatInjector() async {
  injector.registerLazySingleton<DoctorChatRemoteDataSource>(
    () => DoctorChatRemoteDataSourceImpl(apiConsumer: injector()),
  );

  injector.registerLazySingleton<DoctorChatRepository>(
    () => DoctorChatRepositoryImpl(remoteDataSource: injector()),
  );

  injector.registerFactory(
    () => DoctorChatBloc(repository: injector()),
  );
}
