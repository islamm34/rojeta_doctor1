import '../../../core/di/injector.dart';
import '../data/datasources/local/auth_local_data_source_impl.dart';
import '../data/datasources/remote/auth_remote_data_source_impl.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/get_auth.dart';
import '../domain/usecases/login_use_case.dart';
import '../domain/usecases/register_use_case.dart';
import '../domain/usecases/resend_otp_use_case.dart';
import '../domain/usecases/verify_otp_use_case.dart';
import '../domain/usecases/check_phone_use_case.dart';
import '../presentation/bloc/auth_bloc.dart';
import '../../auth/domain/datasources/auth_local_data_source.dart' as local_ds;
import '../../auth/domain/datasources/auth_remote_data_source.dart' as remote_ds;

Future<void> initAuthInjector() async {
  // BLoC
  injector.registerFactory(() => AuthBloc(
        getAuth: injector(),
        registerUseCase: injector(),
        verifyOtpUseCase: injector(),
        loginUseCase: injector(),
        resendOtpUseCase: injector(),
        checkPhoneUseCase: injector(),
      ));

  // UseCases
  injector.registerLazySingleton(() => GetAuthUseCase(injector()));
  injector.registerLazySingleton(() => RegisterUseCase(injector()));
  injector.registerLazySingleton(() => VerifyOtpUseCase(injector()));
  injector.registerLazySingleton(() => LoginUseCase(injector()));
  injector.registerLazySingleton(() => ResendOtpUseCase(injector()));
  injector.registerLazySingleton(() => CheckPhoneUseCase(injector()));

  // Repositories
  injector.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remote: injector(),
        local: injector(),
      ));

  // DataSources
  injector.registerLazySingleton<remote_ds.AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiConsumer: injector()));
  injector.registerLazySingleton<local_ds.AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());
}
