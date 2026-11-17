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

  static double _parseNum(dynamic v, [double def = 0.0]) {
    if (v == null) return def;
    if (v is num) return v.toDouble();
    if (v is String) {
      final clean = v.replaceAll(RegExp(r'[^\d.]'), '').trim();
      return double.tryParse(clean) ?? def;
    }
    return def;
  }

  static int _parseInt(dynamic v, [int def = 0]) {
    if (v == null) return def;
    if (v is num) return v.toInt();
    if (v is String) {
      final clean = v.replaceAll(RegExp(r'[^\d]'), '').trim();
      return int.tryParse(clean) ?? def;
    }
    return def;
  }

  factory FinancialSummaryModel.fromJson(Map<String, dynamic> json) {
    final rawTotal =
        json['totalIncome'] ??
        json['total_income'] ??
        json['totalEarnings'] ??
        json['total_earnings'] ??
        json['totalRevenue'] ??
        json['total_revenue'] ??
        json['total_amount'] ??
        json['total'] ??
        json['gross_amount'];
    final total = _parseNum(rawTotal, 0.0);

    final rawCompleted =
        json['completedAppointments'] ??
        json['completed_appointments'] ??
        json['completed_count'] ??
        json['completedAppointmentsCount'] ??
        json['count'];
    final completed = _parseInt(rawCompleted, 0);

    final rawComm =
        json['commission'] ??
        json['platformFees'] ??
        json['platform_fees'] ??
        json['platformCommission'] ??
        json['platform_commission'] ??
        json['fees_deducted'];
    final comm = _parseNum(rawComm, total > 0 ? (total * 0.1) : 0.0);

    final rawNet =
        json['netIncome'] ??
        json['net_income'] ??
        json['yourEarning'] ??
        json['your_earning'] ??
        json['net_amount'] ??
        json['net'];
    final net = _parseNum(rawNet, total > 0 ? (total - comm) : 0.0);

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
