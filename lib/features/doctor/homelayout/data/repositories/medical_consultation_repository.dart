import 'package:dio/dio.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/network/endpoints.dart';
import '../models/consultation_request_model.dart';

class MedicalConsultationRepository {
  final DioClient _dioClient;

  MedicalConsultationRepository(this._dioClient);

  Future<void> submitConsultation(ConsultationRequestModel request) async {
    try {
      final formData = await request.toFormData();
      await _dioClient.post(
        Endpoints.submitConsultation,
        data: formData,
      );
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data['message'] ?? 'Failed to submit consultation');
      }
      throw Exception(e.toString());
    }
  }
}
