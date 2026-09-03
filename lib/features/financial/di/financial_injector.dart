import '../../../../core/di/injector.dart';
import '../data/datasources/financial_remote_data_source.dart';
import '../data/repositories/financial_repository_impl.dart';
import '../domain/repositories/financial_repository.dart';
import '../domain/usecases/get_financial_summary_usecase.dart';
import '../domain/usecases/get_transactions_usecase.dart';
import '../presentation/bloc/financial_cubit.dart';

Future<void> initFinancialInjector() async {
  // Cubit
  injector.registerFactory(() => FinancialCubit(
        getFinancialSummary: injector(),
        getTransactions: injector(),
      ));

  // UseCases
  injector.registerLazySingleton(() => GetFinancialSummaryUseCase(injector()));
  injector.registerLazySingleton(() => GetTransactionsUseCase(injector()));

  // Repositories
  injector.registerLazySingleton<FinancialRepository>(() => FinancialRepositoryImpl(
        remoteDataSource: injector(),
      ));

  // DataSources
  injector.registerLazySingleton<FinancialRemoteDataSource>(
      () => FinancialRemoteDataSourceImpl(apiConsumer: injector()));
}
