import '../../domain/repositories/i_nursing_repository.dart';
import '../datasources/nursing_remote_data_source.dart';
import '../models/nursing_dashboard_model.dart';
import '../models/nursing_profile_model.dart';
import '../models/nursing_service_model.dart';
import '../models/nursing_staff_model.dart';

class NursingRepositoryImpl implements INursingRepository {
  final NursingRemoteDataSource remoteDataSource;

  NursingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<NursingDashboardModel> getDashboardData() {
    return remoteDataSource.getDashboardData();
  }

  @override
  Future<List<NursingServiceModel>> getServices() {
    return remoteDataSource.getServices();
  }

  @override
  Future<NursingServiceModel> addService(NursingServiceModel service) {
    return remoteDataSource.addService(service);
  }

  @override
  Future<void> deleteService(String id) {
    return remoteDataSource.deleteService(id);
  }

  @override
  Future<({List<NursingStaffModel> staff, NursingStaffStatsModel stats})> getStaff() {
    return remoteDataSource.getStaff();
  }

  @override
  Future<NursingStaffModel> addStaff(NursingStaffModel staff) {
    return remoteDataSource.addStaff(staff);
  }

  @override
  Future<void> deleteStaff(String id) {
    return remoteDataSource.deleteStaff(id);
  }

  @override
  Future<NursingProfileModel> getProfile() {
    return remoteDataSource.getProfile();
  }

  @override
  Future<NursingOfficeInfoModel> getOfficeInfo() {
    return remoteDataSource.getOfficeInfo();
  }

  @override
  Future<void> updateOfficeInfo(NursingOfficeInfoModel officeInfo) {
    return remoteDataSource.updateOfficeInfo(officeInfo);
  }

  @override
  Future<NursingWorkingHoursModel> getWorkingHours() {
    return remoteDataSource.getWorkingHours();
  }

  @override
  Future<void> updateWorkingHours(NursingWorkingHoursModel workingHours) {
    return remoteDataSource.updateWorkingHours(workingHours);
  }

  @override
  Future<NursingSettingsModel> getSettings() {
    return remoteDataSource.getSettings();
  }

  @override
  Future<void> updateSettings(NursingSettingsModel settings) {
    return remoteDataSource.updateSettings(settings);
  }

  @override
  Future<List<NursingCoverageAreaModel>> getCoverageAreas() {
    return remoteDataSource.getCoverageAreas();
  }

  @override
  Future<NursingCoverageAreaModel> addCoverageArea(NursingCoverageAreaModel area) {
    return remoteDataSource.addCoverageArea(area);
  }

  @override
  Future<void> deleteCoverageArea(String id) {
    return remoteDataSource.deleteCoverageArea(id);
  }

  @override
  Future<void> toggleCoverageArea(String id, bool isActive) {
    return remoteDataSource.toggleCoverageArea(id, isActive);
  }

  @override
  Future<List<NursingDocumentItemModel>> getDocuments() {
    return remoteDataSource.getDocuments();
  }

  @override
  Future<NursingDocumentItemModel> uploadDocument(String documentType, String filePath) {
    return remoteDataSource.uploadDocument(documentType, filePath);
  }

  @override
  Future<void> deleteDocument(String id) {
    return remoteDataSource.deleteDocument(id);
  }

  @override
  Future<NursingPaymentSettingsModel> getPaymentSettings() {
    return remoteDataSource.getPaymentSettings();
  }

  @override
  Future<void> updatePaymentSettings(NursingPaymentSettingsModel settings) {
    return remoteDataSource.updatePaymentSettings(settings);
  }
}
