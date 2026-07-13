import 'package:rojeta_doctor/core/di/injector.dart';

import '../presentation/bloc/medical_services_bloc.dart';

Future<void> initMedicalServicesInjector() async {
  // Blocs
  injector.registerLazySingleton(() => MedicalServicesBloc());
}
