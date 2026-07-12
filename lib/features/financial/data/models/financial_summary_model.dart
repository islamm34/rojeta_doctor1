class FinancialSummaryModel {
  final int totalIncome;
  final int completedAppointments;
  final int commission;
  final int netIncome;

  const FinancialSummaryModel({
    required this.totalIncome,
    required this.completedAppointments,
    required this.commission,
    required this.netIncome,
  });

  factory FinancialSummaryModel.fromJson(Map<String, dynamic> json) {
    return FinancialSummaryModel(
      totalIncome: json['totalIncome'] as int? ?? 0,
      completedAppointments: json['completedAppointments'] as int? ?? 0,
      commission: json['commission'] as int? ?? 0,
      netIncome: json['netIncome'] as int? ?? 0,
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
}
