import 'package:dio/dio.dart';

import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import 'profile_remote_data_source.dart';
import '../models/user_profile_response_model.dart';
import '../models/clinic_model.dart';
import '../models/service_pricing_model.dart';
import '../models/payment_details_model.dart';
import '../models/settings_model.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiConsumer apiConsumer;
  Future<UserProfileResponseModel>? _inFlightProfileRequest;

  ProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UserProfileResponseModel> getProfile() async {
    if (_inFlightProfileRequest != null) {
      return _inFlightProfileRequest!;
    }

    final future = () async {
      try {
        final response = await apiConsumer.get(Endpoints.doctorProfile);
        final json = response is Map
            ? Map<String, dynamic>.from(response as Map)
            : <String, dynamic>{};
        return UserProfileResponseModel.fromJson(json);
      } finally {
        _inFlightProfileRequest = null;
      }
    }();

    _inFlightProfileRequest = future;
    return future;
  }

  @override
  Future<void> updateProfile(Map<String, dynamic> data) async {
    await apiConsumer.put(Endpoints.doctorProfile, data: data);
  }

  @override
  Future<String> addClinic(ClinicModel clinic) async {
    final body = await clinic.toRequestBody();
    final response = await apiConsumer.post(
      Endpoints.doctorClinics,
      data: body,
    );
    if (response is Map && response['data'] is Map) {
      return response['data']['id']?.toString() ?? '';
    }
    return '';
  }

  @override
  Future<void> updateClinic(ClinicModel clinic) async {
    final body = await clinic.toRequestBody(isUpdate: true);
    if (body is FormData) {
      await apiConsumer.post(
        Endpoints.doctorClinicDetails(clinic.id),
        data: body,
      );
    } else {
      await apiConsumer.put(
        Endpoints.doctorClinicDetails(clinic.id),
        data: body,
      );
    }
  }

  @override
  Future<void> deleteClinic(String clinicId) async {
    await apiConsumer.delete(Endpoints.doctorClinicDetails(clinicId));
  }

  @override
  Future<void> updateServices(List<ServicePricingModel> services) async {
    await apiConsumer.put(
      Endpoints.doctorServices,
      data: {'services': services.map((s) => s.toJson()).toList()},
    );
  }

  @override
  Future<void> updatePaymentDetails(PaymentDetailsModel paymentDetails) async {
    await apiConsumer.put(
      Endpoints.doctorPaymentDetails,
      data: paymentDetails.toJson(),
    );
  }

  @override
  Future<SettingsModel> getSettings() async {
    final response = await apiConsumer.get(Endpoints.doctorSettings);
    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});
    return SettingsModel.fromJson(data);
  }

  @override
  Future<void> updateSettings(SettingsModel settings) async {
    await apiConsumer.put(Endpoints.doctorSettings, data: settings.toJson());
  }
}
