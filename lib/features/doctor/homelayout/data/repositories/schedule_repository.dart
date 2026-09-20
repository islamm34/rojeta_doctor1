import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  final ApiConsumer apiConsumer;

  ScheduleRepository(this.apiConsumer);

  Future<ScheduleModel> getSchedule() async {
    try {
      final response = await apiConsumer.get(Endpoints.doctorSchedule);
      final data = response is Map<String, dynamic> && response['data'] != null
          ? (response['data'] is Map<String, dynamic>
              ? response['data'] as Map<String, dynamic>
              : response)
          : (response is Map<String, dynamic> ? response : <String, dynamic>{});
      return ScheduleModel.fromJson(data);
    } catch (_) {
      try {
        final fallbackResponse = await apiConsumer.get(Endpoints.getSchedule);
        final data = fallbackResponse is Map<String, dynamic> &&
                fallbackResponse['data'] != null
            ? (fallbackResponse['data'] is Map<String, dynamic>
                ? fallbackResponse['data'] as Map<String, dynamic>
                : fallbackResponse)
            : (fallbackResponse is Map<String, dynamic>
                ? fallbackResponse
                : <String, dynamic>{});
        return ScheduleModel.fromJson(data);
      } catch (_) {
        return ScheduleModel.fromJson(const {});
      }
    }
  }

  Future<void> updateSchedule(ScheduleModel schedule) async {
    try {
      await apiConsumer.put(
        Endpoints.doctorSchedule,
        data: schedule.toJson(),
      );
    } catch (_) {
      try {
        await apiConsumer.post(
          Endpoints.updateSchedule,
          data: schedule.toJson(),
        );
      } catch (_) {
        await apiConsumer.post(
          Endpoints.doctorSchedule,
          data: schedule.toJson(),
        );
      }
    }
  }
}
