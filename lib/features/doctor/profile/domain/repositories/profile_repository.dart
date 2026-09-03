import '../../data/models/user_profile_response_model.dart';
import '../../data/models/clinic_model.dart';
import '../../data/models/service_pricing_model.dart';
import '../../data/models/payment_details_model.dart';
import '../../data/models/settings_model.dart';

abstract class ProfileRepository {
  Future<UserProfileResponseModel> getProfile();
  Future<void> updateProfile(Map<String, dynamic> data);
  Future<String> addClinic(ClinicModel clinic);
  Future<void> updateClinic(String clinicId, Map<String, dynamic> data);
  Future<void> updateServices(List<ServicePricingModel> services);
  Future<void> updatePaymentDetails(PaymentDetailsModel paymentDetails);
  Future<SettingsModel> getSettings();
  Future<void> updateSettings(SettingsModel settings);
}
