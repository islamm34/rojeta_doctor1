import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/endpoints.dart';
import '../../../doctor/chat/data/models/doctor_chat_models.dart';
import '../models/support_contact_model.dart';

abstract class SupportRemoteDataSource {
  Future<SupportContactModel> getSupportContact();
  Future<DoctorConversationModel> getAdminConversation();
}

class SupportRemoteDataSourceImpl implements SupportRemoteDataSource {
  final ApiConsumer apiConsumer;

  const SupportRemoteDataSourceImpl({required this.apiConsumer});

  static const SupportContactModel _defaultSupport = SupportContactModel(
    email: 'support@rojeta.com',
    phone: '+20 100 000 0000',
    availableHours: '9:00 AM - 6:00 PM',
    averageResponseTime: '5 mins',
    adminId: 'admin_support',
    adminName: 'Rojeta Support Team',
  );

  @override
  Future<SupportContactModel> getSupportContact() async {
    try {
      final response = await apiConsumer.get(Endpoints.supportContact);
      if (response is Map<String, dynamic>) {
        final data = response['data'] is Map<String, dynamic>
            ? response['data'] as Map<String, dynamic>
            : response;
        final model = SupportContactModel.fromJson(data);
        return SupportContactModel(
          email: model.email?.isNotEmpty == true ? model.email : _defaultSupport.email,
          phone: model.phone?.isNotEmpty == true ? model.phone : _defaultSupport.phone,
          availableHours: model.availableHours?.isNotEmpty == true
              ? model.availableHours
              : _defaultSupport.availableHours,
          averageResponseTime: model.averageResponseTime?.isNotEmpty == true
              ? model.averageResponseTime
              : _defaultSupport.averageResponseTime,
          adminId: model.adminId?.isNotEmpty == true ? model.adminId : _defaultSupport.adminId,
          adminName: model.adminName?.isNotEmpty == true
              ? model.adminName
              : _defaultSupport.adminName,
          adminAvatar: model.adminAvatar,
        );
      }
      return _defaultSupport;
    } catch (_) {
      return _defaultSupport;
    }
  }

  @override
  Future<DoctorConversationModel> getAdminConversation() async {
    try {
      final response = await apiConsumer.post(Endpoints.supportChatAdmin);
      if (response is Map<String, dynamic>) {
        final data = response['data'] is Map<String, dynamic>
            ? response['data'] as Map<String, dynamic>
            : response;
        return DoctorConversationModel.fromJson(data);
      }
    } catch (_) {
      // Fallback: Return standard admin support conversation
    }

    return DoctorConversationModel(
      id: 'admin_support',
      patientId: 'admin',
      patientName: 'Rojeta Support Team',
      lastMessage: 'Connecting to live support...',
      lastMessageTime: '',
      unreadCount: 0,
    );
  }
}
