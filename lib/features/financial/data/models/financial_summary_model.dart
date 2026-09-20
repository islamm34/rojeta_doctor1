import 'package:equatable/equatable.dart';

class FinancialSummaryModel extends Equatable {
  final double totalIncome;
  final int completedAppointments;
  final double commission;
  final double netIncome;

  const FinancialSummaryModel({
    required this.totalIncome,
    required this.completedAppointments,
    required this.commission,
    required this.netIncome,
  });

  double get totalEarnings => totalIncome;
  double get platformFees => commission;

  factory FinancialSummaryModel.fromJson(Map<String, dynamic> json) {
    final total = (json['totalIncome'] ??
            json['total_income'] ??
            json['totalEarnings'] ??
            json['total_earnings'] ??
            json['totalRevenue'] ??
            json['total_revenue'] ??
            json['total_amount'] as num?)
        ?.toDouble() ??
        0.0;

    final completed = (json['completedAppointments'] ??
            json['completed_appointments'] ??
            json['completed_count'] ??
            json['completedAppointmentsCount'] as num?)
        ?.toInt() ??
        0;

    final comm = (json['commission'] ??
            json['platformFees'] ??
            json['platform_fees'] ??
            json['platformCommission'] ??
            json['platform_commission'] as num?)
        ?.toDouble() ??
        0.0;

    final net = (json['netIncome'] ??
            json['net_income'] ??
            json['yourEarning'] ??
            json['your_earning'] ??
            json['net_amount'] as num?)
        ?.toDouble() ??
        (total > 0 ? total - comm : 0.0);

    return FinancialSummaryModel(
      totalIncome: total,
      completedAppointments: completed,
      commission: comm,
      netIncome: net,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalIncome': totalIncome,
      'completedAppointments': completedAppointments,
      'commission': commission,
      'netIncome': netIncome,
    };
  }

  @override
  List<Object?> get props => [
        totalIncome,
        completedAppointments,
        commission,
        netIncome,
      ];
}
