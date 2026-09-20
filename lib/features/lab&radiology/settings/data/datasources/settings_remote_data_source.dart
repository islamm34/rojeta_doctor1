import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/general_settings_model.dart';
import '../models/lab_info_model.dart';
import '../models/lab_profile_model.dart';
import '../models/working_hours_model.dart';

abstract class SettingsRemoteDataSource {
  Future<LabProfileModel> getLabProfile();
  Future<void> updateLabProfile(LabProfileModel profile);
  Future<GeneralSettingsModel> getGeneralSettings();
  Future<void> updateGeneralSettings(GeneralSettingsModel settings);
  Future<LabInfoModel> getLabInfo();
  Future<void> updateLabInfo(LabInfoModel info);
  Future<WorkingHoursModel> getWorkingHours();
  Future<void> updateWorkingHours(WorkingHoursModel workingHours);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final ApiConsumer apiConsumer;

  SettingsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<LabProfileModel> getLabProfile() async {
    final response = await apiConsumer.get(Endpoints.getLabProfile);
    if (response is Map<String, dynamic>) {
      if (response['data'] is Map<String, dynamic>) {
        return LabProfileModel.fromJson(response['data'] as Map<String, dynamic>);
      }
      return LabProfileModel.fromJson(response);
    }
    return const LabProfileModel();
  }

  @override
  Future<void> updateLabProfile(LabProfileModel profile) async {
    try {
      await apiConsumer.put(Endpoints.getLabProfile, data: profile.toJson());
    } catch (_) {
      try {
        await apiConsumer.put(Endpoints.updateLabProfile, data: profile.toJson());
      } catch (_) {
        try {
          await apiConsumer.post(Endpoints.updateLabProfile, data: profile.toJson());
        } catch (_) {
          await apiConsumer.patch(Endpoints.getLabProfile, data: profile.toJson());
        }
      }
    }
  }

  @override
  Future<GeneralSettingsModel> getGeneralSettings() async {
    final response = await apiConsumer.get(Endpoints.getGeneralSettings);
    if (response is Map<String, dynamic>) {
      if (response['data'] is Map<String, dynamic>) {
        return GeneralSettingsModel.fromJson(response['data'] as Map<String, dynamic>);
      }
      return GeneralSettingsModel.fromJson(response);
    }
    return const GeneralSettingsModel();
  }

  @override
  Future<void> updateGeneralSettings(GeneralSettingsModel settings) async {
    try {
      await apiConsumer.put(Endpoints.getGeneralSettings, data: settings.toJson());
    } catch (_) {
      try {
        await apiConsumer.put(Endpoints.updateGeneralSettings, data: settings.toJson());
      } catch (_) {
        try {
          await apiConsumer.post(Endpoints.updateGeneralSettings, data: settings.toJson());
        } catch (_) {
          await apiConsumer.patch(Endpoints.getGeneralSettings, data: settings.toJson());
        }
      }
    }
  }

  @override
  Future<LabInfoModel> getLabInfo() async {
    final response = await apiConsumer.get(Endpoints.getLabProfile);
    if (response is Map<String, dynamic>) {
      if (response['data'] is Map<String, dynamic>) {
        return LabInfoModel.fromJson(response['data'] as Map<String, dynamic>);
      }
      return LabInfoModel.fromJson(response);
    }
    return const LabInfoModel();
  }

  @override
  Future<void> updateLabInfo(LabInfoModel info) async {
    try {
      await apiConsumer.put(Endpoints.getLabProfile, data: info.toJson());
    } catch (_) {
      try {
        await apiConsumer.put(Endpoints.updateLabProfile, data: info.toJson());
      } catch (_) {
        try {
          await apiConsumer.post(Endpoints.updateLabProfile, data: info.toJson());
        } catch (_) {
          await apiConsumer.patch(Endpoints.getLabProfile, data: info.toJson());
        }
      }
    }
  }

  @override
  Future<WorkingHoursModel> getWorkingHours() async {
    final response = await apiConsumer.get(Endpoints.getWorkingHours);
    if (response is Map<String, dynamic>) {
      if (response['data'] is Map<String, dynamic>) {
        return WorkingHoursModel.fromJson(response['data'] as Map<String, dynamic>);
      }
      return WorkingHoursModel.fromJson(response);
    }
    return const WorkingHoursModel();
  }

  @override
  Future<void> updateWorkingHours(WorkingHoursModel workingHours) async {
    try {
      await apiConsumer.put(Endpoints.getWorkingHours, data: workingHours.toJson());
    } catch (_) {
      try {
        await apiConsumer.put(Endpoints.updateWorkingHours, data: workingHours.toJson());
      } catch (_) {
        try {
          await apiConsumer.post(Endpoints.updateWorkingHours, data: workingHours.toJson());
        } catch (_) {
          await apiConsumer.patch(Endpoints.getWorkingHours, data: workingHours.toJson());
        }
      }
    }
  }
}
