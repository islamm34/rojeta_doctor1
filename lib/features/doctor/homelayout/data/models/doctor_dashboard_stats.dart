class DoctorDashboardStats {
  final int todayAppointments;
  final int pendingRequests;
  final int completedAppointments;
  final int newRequests;
  final double rating;
  final String totalEarnings;

  const DoctorDashboardStats({
    required this.todayAppointments,
    required this.pendingRequests,
    required this.completedAppointments,
    required this.newRequests,
    required this.rating,
    required this.totalEarnings,
  });
}
