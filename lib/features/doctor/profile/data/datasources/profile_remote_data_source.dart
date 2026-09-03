import '../models/user_profile_response_model.dart';
import '../models/clinic_model.dart';
import '../models/service_pricing_model.dart';
import '../models/payment_details_model.dart';
import '../models/settings_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileResponseModel> getProfile();
  Future<void> updateProfile(Map<String, dynamic> data);
  Future<String> addClinic(ClinicModel clinic);
  Future<void> updateClinic(String clinicId, Map<String, dynamic> data);
  Future<void> updateServices(List<ServicePricingModel> services);
  Future<void> updatePaymentDetails(PaymentDetailsModel paymentDetails);
  Future<SettingsModel> getSettings();
  Future<void> updateSettings(SettingsModel settings);
}
