import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/doctor_chat_models.dart';

abstract class DoctorChatRemoteDataSource {
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

class DoctorChatRemoteDataSourceImpl implements DoctorChatRemoteDataSource {
  final ApiConsumer apiConsumer;

  DoctorChatRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<DoctorConversationModel>> getConversations({
    int? page,
    int? limit,
  }) async {
    final query = <String, dynamic>{};
    if (page != null) query['page'] = page;
    if (limit != null) query['limit'] = limit;

    final response = await apiConsumer.get(
      Endpoints.doctorChatConversations,
      queryParameters: query.isNotEmpty ? query : null,
    );

    List<dynamic> rawList = [];
    if (response is List) {
      rawList = response;
    } else if (response is Map) {
      if (response['data'] is List) {
        rawList = response['data'] as List<dynamic>;
      } else if (response['data'] is Map && response['data']['data'] is List) {
        rawList = response['data']['data'] as List<dynamic>;
      } else if (response['conversations'] is List) {
        rawList = response['conversations'] as List<dynamic>;
      }
    }

    return rawList
        .whereType<Map>()
        .map(
          (e) => DoctorConversationModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();
  }

  @override
  Future<List<DoctorChatMessageModel>> getMessages({
    required String conversationId,
    int? page,
    int? limit,
  }) async {
    final query = <String, dynamic>{'conversation_id': conversationId};
    if (page != null) query['page'] = page;
    if (limit != null) query['limit'] = limit;

    final response = await apiConsumer.get(
      Endpoints.doctorChatMessages,
      queryParameters: query,
    );

    List<dynamic> rawList = [];
    if (response is List) {
      rawList = response;
    } else if (response is Map) {
      if (response['data'] is List) {
        rawList = response['data'] as List<dynamic>;
      } else if (response['data'] is Map && response['data']['data'] is List) {
        rawList = response['data']['data'] as List<dynamic>;
      } else if (response['messages'] is List) {
        rawList = response['messages'] as List<dynamic>;
      }
    }

    return rawList
        .whereType<Map>()
        .map(
          (e) => DoctorChatMessageModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();
  }

  @override
  Future<DoctorChatMessageModel> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final response = await apiConsumer.post(
      Endpoints.doctorChatSendMessage,
      data: {'conversation_id': conversationId, 'content': content},
    );

    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});

    return DoctorChatMessageModel.fromJson(data);
  }

  @override
  Future<void> markAsRead({required String conversationId}) async {
    await apiConsumer.post(
      Endpoints.doctorChatMarkRead,
      data: {'conversation_id': conversationId},
    );
  }
}
