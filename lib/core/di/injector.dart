import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/di/homelayout_injector.dart';
import '../../features/auth/di/auth_injector.dart';
import '../../features/financial/di/financial_injector.dart';
import '../../features/hospital/medical_services/di/medical_services_injector.dart';
import '../../features/hospital/settings/di/settings_injector.dart';
import '../../features/lab&radiology/homelayout/di/lab_homelayout_injector.dart';
import '../../features/booking/di/booking_di.dart';
import '../../features/lab&radiology/settings/di/settings_di.dart';
import '../network/api_consumer.dart';
import '../network/dio_client.dart';

final injector = GetIt.instance;

Future<void> setupInjector() async {
  // External
  injector.registerSingleton<Dio>(Dio());
  injector.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // Core
  injector.registerSingleton<ApiConsumer>(DioClient(injector<Dio>()));

  // Features
  await initAuthInjector();
  await initHomelayoutInjector();
  await initFinancialInjector();
  await initMedicalServicesInjector();
  await initSettingsInjector();
  await initLabHomeLayoutInjector();
  initBookingInjector();
  initSettingsDI();
  // ... add other feature injectors
}
