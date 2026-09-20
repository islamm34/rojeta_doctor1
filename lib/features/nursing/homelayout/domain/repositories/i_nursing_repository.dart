import '../../data/models/nursing_dashboard_model.dart';
import '../../data/models/nursing_profile_model.dart';
import '../../data/models/nursing_service_model.dart';
import '../../data/models/nursing_staff_model.dart';

abstract class INursingRepository {
  Future<NursingDashboardModel> getDashboardData();
  Future<List<NursingServiceModel>> getServices();
  Future<NursingServiceModel> addService(NursingServiceModel service);
  Future<void> deleteService(String id);
  Future<({List<NursingStaffModel> staff, NursingStaffStatsModel stats})> getStaff();
  Future<NursingStaffModel> addStaff(NursingStaffModel staff);
  Future<void> deleteStaff(String id);
  Future<NursingProfileModel> getProfile();
  Future<NursingOfficeInfoModel> getOfficeInfo();
  Future<void> updateOfficeInfo(NursingOfficeInfoModel officeInfo);
  Future<NursingWorkingHoursModel> getWorkingHours();
  Future<void> updateWorkingHours(NursingWorkingHoursModel workingHours);
  Future<NursingSettingsModel> getSettings();
  Future<void> updateSettings(NursingSettingsModel settings);
}
