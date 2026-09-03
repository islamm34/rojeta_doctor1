import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/consultation_request_model.dart';

class MedicalConsultationRepository {
  final ApiConsumer apiConsumer;

  MedicalConsultationRepository(this.apiConsumer);

  Future<void> submitConsultation(ConsultationRequestModel request) async {
    final formData = await request.toFormData();
    await apiConsumer.post(
      Endpoints.doctorConsultation,
      data: formData,
    );
  }
}
