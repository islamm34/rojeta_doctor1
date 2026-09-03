import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String id;
  final String patientName;
  final String visitType;
  final String status;
  final String date;
  final String time;
  final double serviceFee;
  final double platformCommission;
  final double yourEarning;

  const TransactionModel({
    this.id = '',
    required this.patientName,
    required this.visitType,
    required this.status,
    required this.date,
    required this.time,
    required this.serviceFee,
    required this.platformCommission,
    required this.yourEarning,
  });

  String get serviceType => visitType;
  double get grossAmount => serviceFee;
  double get feesDeducted => platformCommission;

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String? ?? '',
      patientName: json['patientName'] as String? ?? '',
      visitType: (json['visitType'] ?? json['serviceType']) as String? ?? '',
      status: json['status'] as String? ?? '',
      date: json['date'] as String? ?? '',
      time: json['time'] as String? ?? '',
      serviceFee:
          (json['serviceFee'] ?? json['grossAmount'] as num?)?.toDouble() ?? 0.0,
      platformCommission: (json['platformCommission'] ?? json['feesDeducted'] as num?)
              ?.toDouble() ??
          0.0,
      yourEarning: (json['yourEarning'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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

  @override
  List<Object?> get props => [
        id,
        patientName,
        visitType,
        status,
        date,
        time,
        serviceFee,
        platformCommission,
        yourEarning,
      ];
}
