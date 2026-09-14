import '../datasources/doctor_chat_remote_data_source.dart';
import '../models/doctor_chat_models.dart';

abstract class DoctorChatRepository {
  Future<List<DoctorConversationModel>> getConversations({
    int? page,
    int? limit,
  });

  Future<DoctorConversationModel> startConversation({
    required String patientId,
  });

  Future<DoctorConversationModel> getOrCreateConversation({
    required String patientId,
    String? patientName,
  });

  Future<List<DoctorChatMessageModel>> getMessages({
    required String conversationId,
    int? page,
    int? limit,
  });

  Future<DoctorChatMessageModel> sendMessage({
    required String conversationId,
    required String content,
  });

  Future<void> markAsRead({required String conversationId});
}

class DoctorChatRepositoryImpl implements DoctorChatRepository {
  final DoctorChatRemoteDataSource remoteDataSource;

  DoctorChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<DoctorConversationModel>> getConversations({
    int? page,
    int? limit,
  }) => remoteDataSource.getConversations(page: page, limit: limit);

  @override
  Future<DoctorConversationModel> startConversation({
    required String patientId,
  }) => remoteDataSource.startConversation(patientId: patientId);

  @override
  Future<DoctorConversationModel> getOrCreateConversation({
    required String patientId,
    String? patientName,
  }) async {
    // 1. Try initiating via the backend endpoint (POST /doctor/chat/conversations)
    try {
      return await remoteDataSource.startConversation(patientId: patientId);
    } catch (_) {
      // Endpoint may not be deployed yet or returned 405/404
    }

    // 2. Search existing conversations for matching patientId
    try {
      final conversations = await remoteDataSource.getConversations();
      for (final conv in conversations) {
        if (conv.patientId == patientId) {
          return conv;
        }
      }
    } catch (_) {}

    // 3. Fallback placeholder model until backend conversation is created
    return DoctorConversationModel(
      id: patientId,
      patientId: patientId,
      patientName: patientName ?? '',
      lastMessage: '',
      lastMessageTime: '',
    );
  }

  @override
  Future<List<DoctorChatMessageModel>> getMessages({
    required String conversationId,
    int? page,
    int? limit,
  }) => remoteDataSource.getMessages(
    conversationId: conversationId,
    page: page,
    limit: limit,
  );

  @override
  Future<DoctorChatMessageModel> sendMessage({
    required String conversationId,
    required String content,
  }) => remoteDataSource.sendMessage(
    conversationId: conversationId,
    content: content,
  );

  @override
  Future<void> markAsRead({required String conversationId}) =>
      remoteDataSource.markAsRead(conversationId: conversationId);
}
