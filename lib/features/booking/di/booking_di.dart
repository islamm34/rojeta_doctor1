import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../data/datasources/booking_remote_datasource.dart';
import '../data/repositories/booking_repository_impl.dart';
import '../domain/repositories/booking_repository.dart';
import '../domain/usecases/get_bookings_usecase.dart';
import '../domain/usecases/update_booking_status_usecase.dart';
import '../presentation/bloc/booking_bloc.dart';

final injector = GetIt.instance;

void initBookingInjector() {
  // Bloc
  injector.registerFactory(() => BookingBloc(repository: injector()));

  // Usecases
  injector.registerLazySingleton(() => GetBookingsUseCase(repository: injector()));
  injector.registerLazySingleton(() => UpdateBookingStatusUseCase(repository: injector()));

  // Repository
  injector.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(remoteDataSource: injector()),
  );

  // Data sources
  injector.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(dio: injector()),
  );
}
