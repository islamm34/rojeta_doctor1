import 'package:dio/dio.dart';

import '../../../../../../core/local/user_hive_helper.dart';
import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/nursing_dashboard_model.dart';
import '../models/nursing_profile_model.dart';
import '../models/nursing_service_model.dart';
import '../models/nursing_staff_model.dart';

abstract class NursingRemoteDataSource {
  Future<NursingDashboardModel> getDashboardData();
  Future<List<NursingServiceModel>> getServices();
  Future<NursingServiceModel> addService(NursingServiceModel service);
  Future<void> deleteService(String id);
  Future<({List<NursingStaffModel> staff, NursingStaffStatsModel stats})>
  getStaff();
  Future<NursingStaffModel> addStaff(NursingStaffModel staff);
  Future<void> deleteStaff(String id);
  Future<NursingProfileModel> getProfile();
  Future<NursingOfficeInfoModel> getOfficeInfo();
  Future<void> updateOfficeInfo(NursingOfficeInfoModel officeInfo);
  Future<NursingWorkingHoursModel> getWorkingHours();
  Future<void> updateWorkingHours(NursingWorkingHoursModel workingHours);
  Future<NursingSettingsModel> getSettings();
  Future<void> updateSettings(NursingSettingsModel settings);
  Future<List<NursingCoverageAreaModel>> getCoverageAreas();
  Future<NursingCoverageAreaModel> addCoverageArea(
    NursingCoverageAreaModel area,
  );
  Future<void> deleteCoverageArea(String id);
  Future<void> toggleCoverageArea(String id, bool isActive);
  Future<List<NursingDocumentItemModel>> getDocuments();
  Future<NursingDocumentItemModel> uploadDocument(
    String documentType,
    String filePath,
  );
  Future<void> deleteDocument(String id);
  Future<NursingPaymentSettingsModel> getPaymentSettings();
  Future<void> updatePaymentSettings(NursingPaymentSettingsModel settings);
}

class NursingRemoteDataSourceImpl implements NursingRemoteDataSource {
  final ApiConsumer apiConsumer;

  NursingRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<NursingDashboardModel> getDashboardData() async {
    try {
      final endpoints = [Endpoints.getNursingDashboard, '/nursing/dashboard'];

      for (final ep in endpoints) {
        try {
          final response = await apiConsumer.get(
            ep,
            queryParameters: {'user_type': 'nursing'},
          );
          if (response != null) {
            final data =
                response is Map<String, dynamic> && response['data'] != null
                ? (response['data'] is Map<String, dynamic>
                      ? response['data'] as Map<String, dynamic>
                      : response)
                : (response is Map<String, dynamic>
                      ? response
                      : <String, dynamic>{});
            return NursingDashboardModel.fromJson(data);
          }
        } catch (_) {}
      }
    } catch (_) {}

    return const NursingDashboardModel();
  }

  @override
  Future<List<NursingServiceModel>> getServices() async {
    try {
      final endpoints = [Endpoints.getNursingServices, '/nursing/services'];

      for (final ep in endpoints) {
        try {
          final response = await apiConsumer.get(
            ep,
            queryParameters: {'user_type': 'nursing'},
          );
          if (response != null) {
            List<dynamic> items = [];
            if (response is List) {
              items = response;
            } else if (response is Map<String, dynamic>) {
              final data = response['data'] ?? response['services'];
              if (data is List) {
                items = data;
              }
            }

            return items
                .whereType<Map<String, dynamic>>()
                .map((e) => NursingServiceModel.fromJson(e))
                .toList();
          }
        } catch (_) {}
      }
    } catch (_) {}

    return [];
  }

  @override
  Future<NursingServiceModel> addService(NursingServiceModel service) async {
    final endpoints = [Endpoints.addNursingService, '/nursing/services'];

    for (final ep in endpoints) {
      try {
        final response = await apiConsumer.post(ep, data: service.toJson());
        if (response is Map<String, dynamic>) {
          final data = response['data'] is Map<String, dynamic>
              ? response['data'] as Map<String, dynamic>
              : response;
          return NursingServiceModel.fromJson(data);
        }
      } catch (_) {}
    }

    return service;
  }

  @override
  Future<void> deleteService(String id) async {
    final endpoints = ['/nursing/services/$id'];

    for (final ep in endpoints) {
      try {
        await apiConsumer.delete(ep);
        return;
      } catch (_) {}
    }
  }

  @override
  Future<({List<NursingStaffModel> staff, NursingStaffStatsModel stats})>
  getStaff() async {
    try {
      final endpoints = [Endpoints.getNursingStaff, '/nursing/staff'];

      for (final ep in endpoints) {
        try {
          final response = await apiConsumer.get(ep);
          if (response != null) {
            List<dynamic> items = [];
            NursingStaffStatsModel? stats;

            if (response is List) {
              items = response;
            } else if (response is Map<String, dynamic>) {
              final data = response['data'] ?? response['staff'];
              if (data is List) {
                items = data;
              } else if (data is Map<String, dynamic>) {
                if (data['staff'] is List) items = data['staff'] as List;
                if (data['stats'] is Map<String, dynamic>) {
                  stats = NursingStaffStatsModel.fromJson(
                    data['stats'] as Map<String, dynamic>,
                  );
                }
              }
              if (response['stats'] is Map<String, dynamic>) {
                stats = NursingStaffStatsModel.fromJson(
                  response['stats'] as Map<String, dynamic>,
                );
              }
            }

            final staffList = items
                .whereType<Map<String, dynamic>>()
                .map((e) => NursingStaffModel.fromJson(e))
                .toList();
            stats ??= NursingStaffStatsModel(
              totalStaff: staffList.length,
              available: staffList
                  .where((s) => s.status?.toUpperCase() == 'AVAILABLE')
                  .length,
              onDuty: staffList
                  .where(
                    (s) =>
                        s.status?.toUpperCase() == 'ON DUTY' ||
                        s.status?.toUpperCase() == 'BUSY',
                  )
                  .length,
              onLeave: staffList
                  .where((s) => s.status?.toUpperCase() == 'ON LEAVE')
                  .length,
            );
            return (staff: staffList, stats: stats);
          }
        } catch (_) {}
      }
    } catch (_) {}

    return (
      staff: const <NursingStaffModel>[],
      stats: const NursingStaffStatsModel(),
    );
  }

  @override
  Future<NursingStaffModel> addStaff(NursingStaffModel staff) async {
    final endpoints = [Endpoints.addNursingStaff, '/nursing/staff'];
    final body = await staff.toRequestBody();

    for (final ep in endpoints) {
      try {
        final response = await apiConsumer.post(ep, data: body);
        if (response is Map<String, dynamic>) {
          final data = response['data'] is Map<String, dynamic>
              ? response['data'] as Map<String, dynamic>
              : response;
          return NursingStaffModel.fromJson(data);
        }
      } catch (_) {}
    }

    return staff;
  }

  @override
  Future<void> deleteStaff(String id) async {
    final endpoints = ['/nursing/staff/$id'];

    for (final ep in endpoints) {
      try {
        await apiConsumer.delete(ep);
        return;
      } catch (_) {}
    }
  }

  @override
  Future<NursingProfileModel> getProfile() async {
    try {
      final endpoints = [
        Endpoints.profile,
        Endpoints.getNursingProfile,
        '/nursing/profile',
      ];

      for (final ep in endpoints) {
        try {
          final response = await apiConsumer.get(ep);
          if (response is Map<String, dynamic>) {
            var data = response['data'] is Map<String, dynamic>
                ? response['data'] as Map<String, dynamic>
                : response;
            if (data['user'] is Map<String, dynamic>) {
              data = data['user'] as Map<String, dynamic>;
            }
            return NursingProfileModel.fromJson(data);
          }
        } catch (_) {}
      }
    } catch (_) {}

    final cachedUser = UserHiveHelper.getUser();
    final name = (cachedUser?.name?.isNotEmpty == true)
        ? cachedUser!.name!
        : ((cachedUser?.firstName?.isNotEmpty == true)
              ? cachedUser!.firstName!
              : '');
    final avatar = cachedUser?.image ?? '';

    return NursingProfileModel(
      id: cachedUser?.id?.toString() ?? '',
      name: name,
      licenseNumber: '',
      avatarUrl: avatar,
      servicesCount: 0,
      nursesCount: 0,
    );
  }

  @override
  Future<NursingOfficeInfoModel> getOfficeInfo() async {
    try {
      final endpoints = [
        Endpoints.profile,
        Endpoints.getNursingProfile,
        '/nursing/profile',
      ];

      for (final ep in endpoints) {
        try {
          final response = await apiConsumer.get(ep);
          if (response is Map<String, dynamic>) {
            var data = response['data'] is Map<String, dynamic>
                ? response['data'] as Map<String, dynamic>
                : response;
            if (data['user'] is Map<String, dynamic>) {
              data = data['user'] as Map<String, dynamic>;
            }
            return NursingOfficeInfoModel.fromJson(data);
          }
        } catch (_) {}
      }
    } catch (_) {}

    final cachedUser = UserHiveHelper.getUser();
    final name = (cachedUser?.name?.isNotEmpty == true)
        ? cachedUser!.name!
        : ((cachedUser?.firstName?.isNotEmpty == true)
              ? cachedUser!.firstName!
              : '');
    final email = cachedUser?.email ?? '';
    final phone = cachedUser?.phone ?? '';

    return NursingOfficeInfoModel(
      officeName: name,
      licenseNumber: '',
      email: email,
      phone: phone,
      description: '',
      verificationStatus: '',
    );
  }

  @override
  Future<void> updateOfficeInfo(NursingOfficeInfoModel officeInfo) async {
    final endpoints = [
      Endpoints.getNursingProfile,
      '/nursing/profile',
      Endpoints.profile,
    ];

    for (final ep in endpoints) {
      try {
        await apiConsumer.put(ep, data: officeInfo.toJson());
        return;
      } catch (_) {
        try {
          await apiConsumer.post(ep, data: officeInfo.toJson());
          return;
        } catch (_) {}
      }
    }
  }

  @override
  Future<NursingWorkingHoursModel> getWorkingHours() async {
    try {
      final endpoints = [
        Endpoints.getNursingWorkingHours,
        '/nursing/working-hours',
      ];

      for (final ep in endpoints) {
        try {
          final response = await apiConsumer.get(ep);
          if (response != null) {
            final data =
                response is Map<String, dynamic> && response['data'] != null
                ? (response['data'] is Map<String, dynamic>
                      ? response['data'] as Map<String, dynamic>
                      : response)
                : (response is Map<String, dynamic>
                      ? response
                      : <String, dynamic>{});
            return NursingWorkingHoursModel.fromJson(data);
          }
        } catch (_) {}
      }
    } catch (_) {}

    return const NursingWorkingHoursModel(days: []);
  }

  @override
  Future<void> updateWorkingHours(NursingWorkingHoursModel workingHours) async {
    final endpoints = [
      Endpoints.getNursingWorkingHours,
      '/nursing/working-hours',
    ];

    for (final ep in endpoints) {
      try {
        await apiConsumer.put(ep, data: workingHours.toJson());
        return;
      } catch (_) {
        try {
          await apiConsumer.post(ep, data: workingHours.toJson());
          return;
        } catch (_) {}
      }
    }
  }

  @override
  Future<NursingSettingsModel> getSettings() async {
    try {
      final endpoints = [Endpoints.getNursingSettings, '/nursing/settings'];

      for (final ep in endpoints) {
        try {
          final response = await apiConsumer.get(ep);
          if (response != null) {
            final data =
                response is Map<String, dynamic> && response['data'] != null
                ? (response['data'] is Map<String, dynamic>
                      ? response['data'] as Map<String, dynamic>
                      : response)
                : (response is Map<String, dynamic>
                      ? response
                      : <String, dynamic>{});
            return NursingSettingsModel.fromJson(data);
          }
        } catch (_) {}
      }
    } catch (_) {}

    final cachedUser = UserHiveHelper.getUser();
    return NursingSettingsModel(language: cachedUser?.language ?? 'ar');
  }

  @override
  Future<void> updateSettings(NursingSettingsModel settings) async {
    final endpoints = [Endpoints.getNursingSettings, '/nursing/settings'];

    for (final ep in endpoints) {
      try {
        await apiConsumer.put(ep, data: settings.toJson());
        return;
      } catch (_) {
        try {
          await apiConsumer.post(ep, data: settings.toJson());
          return;
        } catch (_) {}
      }
    }
  }

  @override
  Future<List<NursingCoverageAreaModel>> getCoverageAreas() async {
    try {
      final response = await apiConsumer.get(Endpoints.getNursingCoverageAreas);
      if (response != null) {
        List<dynamic> items = [];
        if (response is List) {
          items = response;
        } else if (response is Map<String, dynamic>) {
          final data =
              response['data'] ??
              response['coverage_areas'] ??
              response['areas'] ??
              response['serviceAreas'];
          if (data is List) {
            items = data;
          } else if (data is Map<String, dynamic> && data['areas'] is List) {
            items = data['areas'] as List;
          }
        }

        if (items.isNotEmpty) {
          return items
              .whereType<Map<String, dynamic>>()
              .map((e) => NursingCoverageAreaModel.fromJson(e))
              .toList();
        }
      }
    } catch (_) {}

    return [];
  }

  @override
  Future<NursingCoverageAreaModel> addCoverageArea(
    NursingCoverageAreaModel area,
  ) async {
    final payload = {
      'name': area.name,
      'area_name': area.name,
      'city': area.city,
      'radius_km': area.radiusKm,
      'radiusKm': area.radiusKm,
      'extra_fee': area.extraFee,
      'extraFee': area.extraFee,
      'is_active': area.isActive,
      'isActive': area.isActive,
    };

    try {
      final response = await apiConsumer.post(
        Endpoints.getNursingCoverageAreas,
        data: payload,
      );
      if (response is Map<String, dynamic>) {
        final data = response['data'] is Map<String, dynamic>
            ? response['data'] as Map<String, dynamic>
            : response;
        return NursingCoverageAreaModel.fromJson(data);
      }
    } catch (_) {}

    return area.copyWith(
      id: area.id.isNotEmpty
          ? area.id
          : DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  @override
  Future<void> deleteCoverageArea(String id) async {
    try {
      await apiConsumer.delete(Endpoints.deleteNursingCoverageArea(id));
    } catch (_) {}
  }

  @override
  Future<void> toggleCoverageArea(String id, bool isActive) async {
    final payload = {'is_active': isActive, 'isActive': isActive};
    try {
      await apiConsumer.patch(
        Endpoints.toggleNursingCoverageArea(id),
        data: payload,
      );
      return;
    } catch (_) {
      try {
        await apiConsumer.put(
          Endpoints.toggleNursingCoverageArea(id),
          data: payload,
        );
        return;
      } catch (_) {}
    }
  }

  @override
  Future<List<NursingDocumentItemModel>> getDocuments() async {
    try {
      final response = await apiConsumer.get(Endpoints.getNursingDocuments);
      if (response != null) {
        List<dynamic> items = [];
        if (response is List) {
          items = response;
        } else if (response is Map<String, dynamic>) {
          final data = response['data'] ?? response['documents'];
          if (data is List) {
            items = data;
          } else if (data is Map<String, dynamic> &&
              data['documents'] is List) {
            items = data['documents'] as List;
          }
        }

        if (items.isNotEmpty) {
          return items
              .whereType<Map<String, dynamic>>()
              .map((e) => NursingDocumentItemModel.fromJson(e))
              .toList();
        }
      }
    } catch (_) {}

    return [];
  }

  @override
  Future<NursingDocumentItemModel> uploadDocument(
    String documentType,
    String filePath,
  ) async {
    final fileName = filePath.split('/').last;

    try {
      final formData = FormData.fromMap({
        'document_type': documentType,
        'type': documentType,
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      final response = await apiConsumer.post(
        Endpoints.uploadNursingDocument,
        data: formData,
      );
      if (response is Map<String, dynamic>) {
        final data = response['data'] is Map<String, dynamic>
            ? response['data'] as Map<String, dynamic>
            : response;
        return NursingDocumentItemModel.fromJson(data);
      }
    } catch (_) {}

    return NursingDocumentItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: documentType,
      fileName: fileName,
      fileUrl: filePath,
      status: 'pending',
      uploadedAt: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<void> deleteDocument(String id) async {
    try {
      await apiConsumer.delete(Endpoints.deleteNursingDocument(id));
    } catch (_) {}
  }

  @override
  Future<NursingPaymentSettingsModel> getPaymentSettings() async {
    try {
      final response = await apiConsumer.get(
        Endpoints.getNursingPaymentSettings,
      );
      if (response != null) {
        final data =
            response is Map<String, dynamic> && response['data'] != null
            ? (response['data'] is Map<String, dynamic>
                  ? response['data'] as Map<String, dynamic>
                  : response)
            : (response is Map<String, dynamic>
                  ? response
                  : <String, dynamic>{});

        return NursingPaymentSettingsModel.fromJson(data);
      }
    } catch (_) {}

    return const NursingPaymentSettingsModel();
  }

  @override
  Future<void> updatePaymentSettings(
    NursingPaymentSettingsModel settings,
  ) async {
    final payload = settings.toJson();

    try {
      await apiConsumer.put(Endpoints.getNursingPaymentSettings, data: payload);
      return;
    } catch (_) {
      try {
        await apiConsumer.post(
          Endpoints.getNursingPaymentSettings,
          data: payload,
        );
        return;
      } catch (_) {}
    }
  }
}
