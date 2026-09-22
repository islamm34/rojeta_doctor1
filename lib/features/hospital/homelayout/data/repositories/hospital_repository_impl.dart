import '../../domain/repositories/i_hospital_repository.dart';
import '../datasources/hospital_remote_data_source.dart';
import '../models/hospital_dashboard_model.dart';

class HospitalRepositoryImpl implements IHospitalRepository {
  final HospitalRemoteDataSource remoteDataSource;

  HospitalRepositoryImpl({required this.remoteDataSource});

  @override
  Future<HospitalDashboardModel> getDashboardData() async {
    return await remoteDataSource.getDashboardData();
  }
}
