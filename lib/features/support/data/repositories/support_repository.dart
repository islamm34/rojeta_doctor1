import '../../../doctor/chat/data/models/doctor_chat_models.dart';
import '../../domain/repositories/i_support_repository.dart';
import '../datasources/support_remote_data_source.dart';
import '../models/support_contact_model.dart';

class SupportRepository implements ISupportRepository {
  final SupportRemoteDataSource remoteDataSource;

  const SupportRepository({required this.remoteDataSource});

  @override
  Future<SupportContactModel> getSupportContact() {
    return remoteDataSource.getSupportContact();
  }

  @override
  Future<DoctorConversationModel> getAdminConversation() {
    return remoteDataSource.getAdminConversation();
  }
}
