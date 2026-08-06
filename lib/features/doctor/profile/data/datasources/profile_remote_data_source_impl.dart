import 'package:rojeta_doctor/core/network/api_consumer.dart';
import 'package:rojeta_doctor/core/network/endpoints.dart';
import 'profile_remote_data_source.dart';
import '../models/user_profile_response_model.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UserProfileResponseModel> getProfile() async {
    final response = await apiConsumer.get(Endpoints.profile);
    return UserProfileResponseModel.fromJson(response);
  }
}
