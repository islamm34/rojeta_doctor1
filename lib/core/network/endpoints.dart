class Endpoints {
  static const String baseUrl = 'https://rojeta.fassla.net/api/v1';
  static const String authTokenKey = 'auth_token';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String login = '/auth/login';
  static const String checkPhone = '/auth/check-phone';

  static const String profile = '/auth/profile';

  // --- Doctor Endpoints ---
  static const String doctorDashboard = '/doctor/dashboard';
  static const String doctorProfileSummary = '/doctor/profile/summary';
  static const String doctorAppointments = '/doctor/appointments';
  static String doctorAppointmentDetails(String appointmentId) =>
      '/doctor/appointments/$appointmentId';
  static String doctorAppointmentStatus(String appointmentId) =>
      '/doctor/appointments/$appointmentId/status';
  static const String doctorPatients = '/doctor/patients';
  static String doctorPatientDetails(String patientId) =>
      '/doctor/patients/$patientId';
  static const String doctorConsultation = '/doctor/consultation';
  static const String doctorSchedule = '/doctor/schedule';
  static const String doctorProfile = '/doctor/profile';
  static const String doctorClinics = '/doctor/clinics';
  static String doctorClinicDetails(String clinicId) =>
      '/doctor/clinics/$clinicId';
  static const String doctorServices = '/doctor/services';
  static const String doctorPaymentDetails = '/doctor/payment-details';
  static const String doctorAnalytics = '/doctor/analytics';
  static const String doctorMarketingPackages = '/doctor/marketing/packages';
  static const String doctorMarketingSubscribe = '/doctor/marketing/subscribe';
  static const String doctorNotifications = '/doctor/notifications';
  static String doctorNotificationRead(String notificationId) =>
      '/doctor/notifications/$notificationId/read';
  static const String doctorSettings = '/doctor/settings';
  static const String doctorChatConversations = '/doctor/chat/conversations';
  static const String doctorChatMessages = '/doctor/chat/messages';
  static const String doctorChatSendMessage = '/doctor/chat/send-message';
  static const String doctorChatMarkRead = '/doctor/chat/mark-read';

  // --- Public & Patient Endpoints ---
  static const String laboratoryTestsCatalog = '/laboratory/tests';
  static const String radiologyScansCatalog = '/radiology/scans';
  static const String laboratoriesList = '/laboratories';
  static String laboratoryTests(String providerId) =>
      '/laboratories/$providerId/tests';
  static String radiologyServices(String providerId) =>
      '/radiology/$providerId/services';
  static const String serviceProviderDetails = '/service-providers/details';
  static String serviceProviderReviews(String providerId) =>
      '/service-providers/$providerId/reviews';

  // --- Bookings Endpoints ---
  static const String createLabBooking = '/bookings/laboratory/create';
  static const String createRadiologyBooking = '/bookings/radiology/create';
  static const String bookings = '/bookings';
  static String bookingStatus(String bookingId) =>
      '/bookings/$bookingId/status';
  static const String getBookings = '/bookings';
  static String updateBookingStatus(String bookingId) =>
      '/bookings/$bookingId/status';

  // --- Financial & Notifications Endpoints ---
  static const String financialSummary = '/financial/summary';
  static const String financialTransactions = '/financial/transactions';
  static const String notifications = '/notifications/get';
  static const String getFinancialData = '/financial';

  static const String registrationStatus = '/registration-status';
  static const String addClinic = '/clinics/add';
  static const String getMarketingAnalytics = '/marketing/analytics';
  static const String submitConsultation = '/consultation/submit';
  static const String getSchedule = '/schedule';
  static const String updateSchedule = '/schedule/update';

  // --- Laboratory & Radiology Provider Endpoints ---
  static const String laboratoryAddTest = '/lab/test/add';
  static const String addLabService = '/lab/service/add';
  static const String labDashboard = '/lab/dashboard';
  static const String labServices = '/lab/services';
  static const String labTests = '/lab/tests';
  static String labDeleteService(String id) => '/lab/services/$id';
  static String labDeleteTest(String id) => '/lab/tests/$id';
  static String labUpdateService(String id) => '/lab/services/$id';
  static String labUpdateTest(String id) => '/lab/tests/$id';
  static const String getBranches = '/lab/branches';
  static const String addBranch = '/lab/branches/add';
  static String deleteBranch(String id) => '/lab/branches/$id';
  static const String getHomeVisitConfig = '/lab/home-visits/config';
  static const String updateHomeVisitConfig = '/lab/home-visits/config/update';
  static const String getLabProfile = '/lab/profile';
  static const String updateLabProfile = '/lab/profile/update';
  static const String getGeneralSettings = '/lab/settings';
  static const String updateGeneralSettings = '/lab/settings/update';
  static const String getWorkingHours = '/lab/working-hours';
  static const String updateWorkingHours = '/lab/working-hours/update';

  // --- Nursing Endpoints ---
  static const String getNursingDashboard = '/nursing/dashboard';
  static const String getNursingServices = '/nursing/services';
  static const String addNursingService = '/nursing/services/add';
  static const String getNursingStaff = '/nursing/staff';
  static const String addNursingStaff = '/nursing/staff/add';
}
