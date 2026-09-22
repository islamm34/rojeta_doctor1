import '../../data/models/hospital_dashboard_model.dart';

abstract class IHospitalRepository {
  Future<HospitalDashboardModel> getDashboardData();
}
