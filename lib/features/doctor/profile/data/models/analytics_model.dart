class AppointmentTypeStatModel {
  final String typeKey;
  final int count;
  final int percentage;
  final double revenue;

  const AppointmentTypeStatModel({
    required this.typeKey,
    required this.count,
    required this.percentage,
    required this.revenue,
  });

  factory AppointmentTypeStatModel.fromJson(Map<String, dynamic> json) {
    return AppointmentTypeStatModel(
      typeKey: json['typeKey'] as String? ?? '',
      count: json['count'] as int? ?? 0,
      percentage: json['percentage'] as int? ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class WeeklyStatModel {
  final String weekLabel;
  final int patients;
  final double revenue;
  final double patientsPercent;
  final double revenuePercent;

  const WeeklyStatModel({
    required this.weekLabel,
    required this.patients,
    required this.revenue,
    required this.patientsPercent,
    required this.revenuePercent,
  });

  factory WeeklyStatModel.fromJson(Map<String, dynamic> json) {
    return WeeklyStatModel(
      weekLabel: json['weekLabel'] as String? ?? '',
      patients: json['patients'] as int? ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      patientsPercent: (json['patientsPercent'] as num?)?.toDouble() ?? 0.0,
      revenuePercent: (json['revenuePercent'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class AnalyticsModel {
  final String monthLabel;
  final int totalPatients;
  final int newPatients;
  final int returningPatients;
  final double totalRevenue;
  final double expenses;
  final double netIncome;
  final double avgPerPatient;
  final int totalAppointments;
  final int completedAppointments;
  final int cancelledAppointments;
  final double patientGrowthPercent;
  final double revenueGrowthPercent;
  final double successRate;
  final List<AppointmentTypeStatModel> appointmentTypes;
  final List<WeeklyStatModel> weeklyStats;

  const AnalyticsModel({
    required this.monthLabel,
    required this.totalPatients,
    required this.newPatients,
    required this.returningPatients,
    required this.totalRevenue,
    required this.expenses,
    required this.netIncome,
    required this.avgPerPatient,
    required this.totalAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    required this.patientGrowthPercent,
    required this.revenueGrowthPercent,
    required this.successRate,
    required this.appointmentTypes,
    required this.weeklyStats,
  });

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsModel(
      monthLabel: json['monthLabel'] as String? ?? '',
      totalPatients: json['totalPatients'] as int? ?? 0,
      newPatients: json['newPatients'] as int? ?? 0,
      returningPatients: json['returningPatients'] as int? ?? 0,
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      expenses: (json['expenses'] as num?)?.toDouble() ?? 0.0,
      netIncome: (json['netIncome'] as num?)?.toDouble() ?? 0.0,
      avgPerPatient: (json['avgPerPatient'] as num?)?.toDouble() ?? 0.0,
      totalAppointments: json['totalAppointments'] as int? ?? 0,
      completedAppointments: json['completedAppointments'] as int? ?? 0,
      cancelledAppointments: json['cancelledAppointments'] as int? ?? 0,
      patientGrowthPercent:
          (json['patientGrowthPercent'] as num?)?.toDouble() ?? 0.0,
      revenueGrowthPercent:
          (json['revenueGrowthPercent'] as num?)?.toDouble() ?? 0.0,
      successRate: (json['successRate'] as num?)?.toDouble() ?? 0.0,
      appointmentTypes:
          (json['appointmentTypes'] as List<dynamic>?)
              ?.map(
                (e) => AppointmentTypeStatModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      weeklyStats:
          (json['weeklyStats'] as List<dynamic>?)
              ?.map((e) => WeeklyStatModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
