import '../models/analytics_model.dart';

class AnalyticsMockData {
  static AnalyticsModel get analytics => AnalyticsModel(
        monthLabel: 'April 2026',
        totalPatients: 145,
        newPatients: 42,
        returningPatients: 103,
        totalRevenue: 58750,
        expenses: 12180,
        netIncome: 46450,
        avgPerPatient: 405,
        totalAppointments: 178,
        completedAppointments: 156,
        cancelledAppointments: 34,
        patientGrowthPercent: 18.5,
        revenueGrowthPercent: 22.3,
        successRate: 87.6,
        appointmentTypes: const [
          AppointmentTypeStatModel(
            typeKey: 'clinicVisit',
            count: 98,
            percentage: 55,
            revenue: 29400,
          ),
          AppointmentTypeStatModel(
            typeKey: 'homeVisit',
            count: 34,
            percentage: 19,
            revenue: 17000,
          ),
          AppointmentTypeStatModel(
            typeKey: 'videoCall',
            count: 28,
            percentage: 16,
            revenue: 8400,
          ),
          AppointmentTypeStatModel(
            typeKey: 'followUp',
            count: 18,
            percentage: 10,
            revenue: 3950,
          ),
        ],
        weeklyStats: const [
          WeeklyStatModel(
            weekLabel: 'Week 1',
            patients: 32,
            revenue: 12500,
            patientsPercent: 0.78,
            revenuePercent: 0.74,
          ),
          WeeklyStatModel(
            weekLabel: 'Week 2',
            patients: 38,
            revenue: 15200,
            patientsPercent: 0.93,
            revenuePercent: 0.90,
          ),
          WeeklyStatModel(
            weekLabel: 'Week 3',
            patients: 41,
            revenue: 16800,
            patientsPercent: 1.0,
            revenuePercent: 1.0,
          ),
          WeeklyStatModel(
            weekLabel: 'Week 4',
            patients: 34,
            revenue: 14250,
            patientsPercent: 0.83,
            revenuePercent: 0.85,
          ),
        ],
      );
}
