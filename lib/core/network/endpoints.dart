class Endpoints {
  static const String baseUrl = 'https://rojeta.fassla.net/api/v1';
  static const String authTokenKey = 'auth_token';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String login = '/auth/login';
  static const String checkPhone = '/auth/check-phone';


  static const String profile = '/auth/profile';



  static const String registrationStatus = '/registration-status';
  static const String notifications = '/notifications';
  static const String getFinancialData = '/financial';
  static const String addClinic = '/clinics/add';
  static const String getMarketingAnalytics = '/marketing/analytics';
  static const String submitConsultation = '/consultation/submit';
  static const String getSchedule = '/schedule';
  static const String updateSchedule = '/schedule/update';
  static const String laboratoryAddTest = '/lab/test/add';
  static const String addLabService = '/lab/service/add';
  static const String getBookings = '/lab/bookings';
  static const String updateBookingStatus = '/lab/bookings/update-status';
  static const String getBranches = '/lab/branches';
  static const String addBranch = '/lab/branches/add';
  static const String getHomeVisitConfig = '/lab/home-visits/config';
  static const String updateHomeVisitConfig = '/lab/home-visits/config/update';
  static const String getLabProfile = '/lab/profile';
  static const String updateLabProfile = '/lab/profile/update';
  static const String getGeneralSettings = '/lab/settings';
  static const String updateGeneralSettings = '/lab/settings/update';
  static const String getWorkingHours = '/lab/working-hours';
  static const String updateWorkingHours = '/lab/working-hours/update';
  static const String getNursingDashboard = '/nursing/dashboard';
  static const String getNursingServices = '/nursing/services';
  static const String addNursingService = '/nursing/services/add';
  static const String getNursingStaff = '/nursing/staff';
  static const String addNursingStaff = '/nursing/staff/add';
}
