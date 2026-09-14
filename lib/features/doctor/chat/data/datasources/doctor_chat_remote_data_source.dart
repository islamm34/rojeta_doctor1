import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/doctor_chat_models.dart';

abstract class DoctorChatRemoteDataSource {
  Future<List<DoctorConversationModel>> getConversations({
    int? page,
    int? limit,
  });

  Future<DoctorConversationModel> startConversation({
    required String patientId,
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
  Future<DoctorConversationModel> startConversation({
    required String patientId,
  }) async {
    final cleanPatientId = _cleanConversationId(patientId);
    final response = await apiConsumer.post(
      Endpoints.doctorChatConversations,
      data: {'patient_id': cleanPatientId},
    );

    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});

    return DoctorConversationModel.fromJson(data);
  }

  String _cleanConversationId(String id) {
    return id.startsWith('conv_') ? id.substring(5) : id;
  }

  @override
  Future<List<DoctorChatMessageModel>> getMessages({
    required String conversationId,
    int? page,
    int? limit,
  }) async {
    final cleanId = _cleanConversationId(conversationId);
    final query = <String, dynamic>{'conversation_id': cleanId};
    if (page != null) query['page'] = page;
    if (limit != null) query['limit'] = limit;

    try {
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
        } else if (response['data'] is Map &&
            response['data']['data'] is List) {
          rawList = response['data']['data'] as List<dynamic>;
        } else if (response['messages'] is List) {
          rawList = response['messages'] as List<dynamic>;
        }
      }

      return rawList
          .whereType<Map>()
          .map(
            (e) =>
                DoctorChatMessageModel.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList();
    } catch (e) {
      if (e.toString().contains('404') || e.toString().contains('NOT_FOUND')) {
        return [];
      }
      rethrow;
    }
  }

  @override
  Future<DoctorChatMessageModel> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final cleanId = _cleanConversationId(conversationId);
    final response = await apiConsumer.post(
      Endpoints.doctorChatSendMessage,
      data: {'conversation_id': cleanId, 'content': content},
    );

    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});

    return DoctorChatMessageModel.fromJson(data);
  }

  @override
  Future<void> markAsRead({required String conversationId}) async {
    final cleanId = _cleanConversationId(conversationId);
    await apiConsumer.post(
      Endpoints.doctorChatMarkRead,
      data: {'conversation_id': cleanId},
    );
  }
}
