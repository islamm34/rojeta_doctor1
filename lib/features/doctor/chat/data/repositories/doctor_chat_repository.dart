import '../datasources/doctor_chat_remote_data_source.dart';
import '../models/doctor_chat_models.dart';

abstract class DoctorChatRepository {
  Future<List<DoctorConversationModel>> getConversations({
    int? page,
    int? limit,
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
  }) =>
      remoteDataSource.getConversations(page: page, limit: limit);

  @override
  Future<List<DoctorChatMessageModel>> getMessages({
    required String conversationId,
    int? page,
    int? limit,
  }) =>
      remoteDataSource.getMessages(
        conversationId: conversationId,
        page: page,
        limit: limit,
      );

  @override
  Future<DoctorChatMessageModel> sendMessage({
    required String conversationId,
    required String content,
  }) =>
      remoteDataSource.sendMessage(
        conversationId: conversationId,
        content: content,
      );

  @override
  Future<void> markAsRead({required String conversationId}) =>
      remoteDataSource.markAsRead(conversationId: conversationId);
}
