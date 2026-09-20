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
    final endpoints = [Endpoints.getLabProfile, '/radiology/profile', '/radiology/info', '/lab/profile'];
    dynamic response;
    for (final ep in endpoints) {
      try {
        response = await apiConsumer.get(ep);
        if (response != null) break;
      } catch (_) {}
    }

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
    final endpoints = [
      Endpoints.getLabProfile,
      Endpoints.updateLabProfile,
      '/radiology/profile',
      '/radiology/info',
      '/lab/profile',
    ];

    for (final ep in endpoints) {
      try {
        await apiConsumer.put(ep, data: profile.toJson());
        return;
      } catch (_) {
        try {
          await apiConsumer.post(ep, data: profile.toJson());
          return;
        } catch (_) {
          try {
            await apiConsumer.patch(ep, data: profile.toJson());
            return;
          } catch (_) {}
        }
      }
    }
  }

  @override
  Future<GeneralSettingsModel> getGeneralSettings() async {
    final endpoints = [Endpoints.getGeneralSettings, '/radiology/settings/general', '/lab/settings/general'];
    dynamic response;
    for (final ep in endpoints) {
      try {
        response = await apiConsumer.get(ep);
        if (response != null) break;
      } catch (_) {}
    }

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
    final endpoints = [
      Endpoints.getGeneralSettings,
      Endpoints.updateGeneralSettings,
      '/radiology/settings/general',
      '/lab/settings/general',
    ];

    for (final ep in endpoints) {
      try {
        await apiConsumer.put(ep, data: settings.toJson());
        return;
      } catch (_) {
        try {
          await apiConsumer.post(ep, data: settings.toJson());
          return;
        } catch (_) {
          try {
            await apiConsumer.patch(ep, data: settings.toJson());
            return;
          } catch (_) {}
        }
      }
    }
  }

  @override
  Future<LabInfoModel> getLabInfo() async {
    final endpoints = [Endpoints.getLabProfile, '/radiology/profile', '/radiology/info', '/lab/profile'];
    dynamic response;
    for (final ep in endpoints) {
      try {
        response = await apiConsumer.get(ep);
        if (response != null) break;
      } catch (_) {}
    }

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
    final endpoints = [
      Endpoints.getLabProfile,
      Endpoints.updateLabProfile,
      '/radiology/profile',
      '/radiology/info',
      '/lab/profile',
    ];

    for (final ep in endpoints) {
      try {
        await apiConsumer.put(ep, data: info.toJson());
        return;
      } catch (_) {
        try {
          await apiConsumer.post(ep, data: info.toJson());
          return;
        } catch (_) {
          try {
            await apiConsumer.patch(ep, data: info.toJson());
            return;
          } catch (_) {}
        }
      }
    }
  }

  @override
  Future<WorkingHoursModel> getWorkingHours() async {
    final endpoints = [Endpoints.getWorkingHours, '/radiology/working-hours', '/lab/working-hours'];
    dynamic response;
    for (final ep in endpoints) {
      try {
        response = await apiConsumer.get(ep);
        if (response != null) break;
      } catch (_) {}
    }

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
    final endpoints = [
      Endpoints.getWorkingHours,
      Endpoints.updateWorkingHours,
      '/radiology/working-hours',
      '/lab/working-hours',
    ];

    for (final ep in endpoints) {
      try {
        await apiConsumer.put(ep, data: workingHours.toJson());
        return;
      } catch (_) {
        try {
          await apiConsumer.post(ep, data: workingHours.toJson());
          return;
        } catch (_) {
          try {
            await apiConsumer.patch(ep, data: workingHours.toJson());
            return;
          } catch (_) {}
        }
      }
    }
  }
}
