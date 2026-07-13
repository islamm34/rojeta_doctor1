import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/lab_profile_model.dart';
import '../models/general_settings_model.dart';

abstract class SettingsRemoteDataSource {
  Future<LabProfileModel> getLabProfile();
  Future<GeneralSettingsModel> getGeneralSettings();
  Future<void> updateGeneralSettings(GeneralSettingsModel settings);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final ApiConsumer apiConsumer;

  SettingsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<LabProfileModel> getLabProfile() async {
    // Simulated remote call since it's mock
    // final response = await apiConsumer.get(Endpoints.getLabProfile);
    // return LabProfileModel.fromJson(response);
    await Future.delayed(const Duration(milliseconds: 500));
    return const LabProfileModel(
      labName: 'City Lab',
      licenseNo: 'LAB-2023-994821',
      branchesCount: 12,
      scansCount: 45,
      iconUrl: 'https://via.placeholder.com/150',
    );
  }

  @override
  Future<GeneralSettingsModel> getGeneralSettings() async {
    // Simulated remote call
    await Future.delayed(const Duration(milliseconds: 500));
    return const GeneralSettingsModel(
      emailNotifications: true,
      bookingUpdates: true,
      pushNotifications: true,
      appointmentReminders: true,
      marketingEmails: false,
    );
  }

  @override
  Future<void> updateGeneralSettings(GeneralSettingsModel settings) async {
    // Simulated remote call
    // await apiConsumer.post(Endpoints.updateGeneralSettings, body: settings.toJson());
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
