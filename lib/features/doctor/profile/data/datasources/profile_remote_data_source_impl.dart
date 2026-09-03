import 'package:rojeta_doctor/core/network/api_consumer.dart';
import 'package:rojeta_doctor/core/network/endpoints.dart';
import 'profile_remote_data_source.dart';
import '../models/user_profile_response_model.dart';

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
        final response = await apiConsumer.get(Endpoints.profile);
        return UserProfileResponseModel.fromJson(response);
      } finally {
        _inFlightProfileRequest = null;
      }
    }();

    _inFlightProfileRequest = future;
    return future;
  }
}
