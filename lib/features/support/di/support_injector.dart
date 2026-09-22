import 'package:get_it/get_it.dart';
import '../../../core/network/api_consumer.dart';
import '../data/datasources/support_remote_data_source.dart';
import '../data/repositories/support_repository.dart';
import '../domain/repositories/i_support_repository.dart';
import '../presentation/cubit/support_cubit.dart';

Future<void> initSupportInjector() async {
  final injector = GetIt.instance;

  // Data Source
  injector.registerLazySingleton<SupportRemoteDataSource>(
    () => SupportRemoteDataSourceImpl(apiConsumer: injector<ApiConsumer>()),
  );

  // Repository
  injector.registerLazySingleton<ISupportRepository>(
    () => SupportRepository(remoteDataSource: injector<SupportRemoteDataSource>()),
  );

  // Cubit
  injector.registerFactory<SupportCubit>(
    () => SupportCubit(repository: injector<ISupportRepository>()),
  );
}
