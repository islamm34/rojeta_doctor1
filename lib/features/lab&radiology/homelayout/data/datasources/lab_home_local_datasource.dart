import '../models/lab_home_model.dart';
import '../models/lab_upcoming_booking_model.dart';
import '../models/lab_special_offer_model.dart';

abstract class LabHomeLocalDataSource {
  Future<LabHomeModel> getDashboardData();
}

class LabHomeLocalDataSourceImpl implements LabHomeLocalDataSource {
  @override
  Future<LabHomeModel> getDashboardData() async {
    // Return mock data that matches the screenshot exactly
    return const LabHomeModel(
      todayBookings: 12,
      todayBookingsProgress: '+2 since 8 AM',
      pendingRequests: 5,
      homeVisits: 8,
      upcomingBooking: LabUpcomingBookingModel(
        patientName: 'Sarah Jenkins',
        testCategory: 'Blood Panel',
        appointmentTime: '10:30 AM',
        appointmentDate: 'MAY 24',
      ),
      specialOffer: LabSpecialOfferModel(
        title: 'Upgrade to Premium',
        description: 'Get advanced analytics and unlimited appointments',
        discount: '30%',
      ),
    );
  }
}
