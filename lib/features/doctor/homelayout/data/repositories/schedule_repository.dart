import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  final ApiConsumer apiConsumer;

  ScheduleRepository(this.apiConsumer);

  Future<ScheduleModel> getSchedule() async {
    final response = await apiConsumer.get(Endpoints.doctorSchedule);
    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});
    return ScheduleModel.fromJson(data);
  }

  Future<void> updateSchedule(ScheduleModel schedule) async {
    await apiConsumer.put(
      Endpoints.doctorSchedule,
      data: schedule.toJson(),
    );
  }
}
