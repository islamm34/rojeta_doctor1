import 'package:rojeta_doctor/core/local/user_hive_helper.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/user_profile_response_model.dart';
import '../models/clinic_model.dart';
import '../models/service_pricing_model.dart';
import '../models/payment_details_model.dart';
import '../models/settings_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserProfileResponseModel> getProfile() async {
    final response = await remoteDataSource.getProfile();
    if (response.user != null) {
      UserHiveHelper.saveUser(response.user!);
    }
    return response;
  }

  @override
  Future<void> updateProfile(Map<String, dynamic> data) =>
      remoteDataSource.updateProfile(data);

  @override
  Future<String> addClinic(ClinicModel clinic) =>
      remoteDataSource.addClinic(clinic);

  @override
  Future<void> updateClinic(ClinicModel clinic) =>
      remoteDataSource.updateClinic(clinic);

  @override
  Future<void> deleteClinic(String clinicId) =>
      remoteDataSource.deleteClinic(clinicId);

  @override
  Future<void> updateServices(List<ServicePricingModel> services) =>
      remoteDataSource.updateServices(services);

  @override
  Future<void> updatePaymentDetails(PaymentDetailsModel paymentDetails) =>
      remoteDataSource.updatePaymentDetails(paymentDetails);

  @override
  Future<SettingsModel> getSettings() => remoteDataSource.getSettings();

  @override
  Future<void> updateSettings(SettingsModel settings) =>
      remoteDataSource.updateSettings(settings);
}
