import 'package:dio/dio.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/network/endpoints.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  final DioClient _dioClient;

  ScheduleRepository(this._dioClient);

  Future<ScheduleModel> getSchedule() async {
    try {
      final response = await _dioClient.get(Endpoints.getSchedule);
      if (response.data != null) {
        return ScheduleModel.fromJson(response.data);
      }
      return _getMockSchedule();
    } catch (e) {
      // Return mock data if endpoint fails
      return _getMockSchedule();
    }
  }

  Future<void> updateSchedule(ScheduleModel schedule) async {
    try {
      await _dioClient.post(
        Endpoints.updateSchedule,
        data: schedule.toJson(),
      );
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data['message'] ?? 'Failed to update schedule');
      }
      throw Exception(e.toString());
    }
  }

  ScheduleModel _getMockSchedule() {
    return ScheduleModel(
      workingDays: [
        WorkingDayModel(
          dayName: 'Monday',
          isActive: true,
          timeSlots: [
            const TimeSlotModel(startTime: '5:00 PM', endTime: '6:00 PM'),
            const TimeSlotModel(startTime: '7:00 PM', endTime: '8:00 PM'),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Tuesday',
          isActive: true,
          timeSlots: [
            TimeSlotModel(startTime: '', endTime: ''),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Wednesday',
          isActive: true,
          timeSlots: [
            TimeSlotModel(startTime: '', endTime: ''),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Thursday',
          isActive: true,
          timeSlots: [
            TimeSlotModel(startTime: '', endTime: ''),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Friday',
          isActive: false,
          timeSlots: [],
        ),
        const WorkingDayModel(
          dayName: 'Saturday',
          isActive: true,
          timeSlots: [
            TimeSlotModel(startTime: '', endTime: ''),
          ],
        ),
        const WorkingDayModel(
          dayName: 'Sunday',
          isActive: false,
          timeSlots: [],
        ),
      ],
      vacations: const [
        VacationModel(
          id: '1',
          startDate: '2026-02-12',
          endDate: '2026-02-27',
        )
      ],
    );
  }
}
