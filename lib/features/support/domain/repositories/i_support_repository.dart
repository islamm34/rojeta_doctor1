import '../../../doctor/chat/data/models/doctor_chat_models.dart';
import '../../data/models/support_contact_model.dart';

abstract class ISupportRepository {
  Future<SupportContactModel> getSupportContact();
  Future<DoctorConversationModel> getAdminConversation();
}
