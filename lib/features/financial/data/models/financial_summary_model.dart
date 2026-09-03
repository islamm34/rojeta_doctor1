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
    return FinancialSummaryModel(
      totalIncome: (json['totalIncome'] as num?)?.toDouble() ?? 0.0,
      completedAppointments:
          (json['completedAppointments'] as num?)?.toInt() ?? 0,
      commission: (json['commission'] as num?)?.toDouble() ?? 0.0,
      netIncome: (json['netIncome'] as num?)?.toDouble() ?? 0.0,
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
