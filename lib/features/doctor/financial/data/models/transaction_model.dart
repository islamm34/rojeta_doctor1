class TransactionModel {
  final String patientName;
  final String visitType;
  final String status;
  final String date;
  final String time;
  final int serviceFee;
  final int platformCommission;
  final int yourEarning;

  const TransactionModel({
    required this.patientName,
    required this.visitType,
    required this.status,
    required this.date,
    required this.time,
    required this.serviceFee,
    required this.platformCommission,
    required this.yourEarning,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      patientName: json['patientName'] as String? ?? '',
      visitType: json['visitType'] as String? ?? '',
      status: json['status'] as String? ?? '',
      date: json['date'] as String? ?? '',
      time: json['time'] as String? ?? '',
      serviceFee: json['serviceFee'] as int? ?? 0,
      platformCommission: json['platformCommission'] as int? ?? 0,
      yourEarning: json['yourEarning'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'visitType': visitType,
      'status': status,
      'date': date,
      'time': time,
      'serviceFee': serviceFee,
      'platformCommission': platformCommission,
      'yourEarning': yourEarning,
    };
  }
}
