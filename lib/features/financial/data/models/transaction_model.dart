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
    final patientObj = json['patient'] as Map<String, dynamic>?;
    final userObj = json['user'] as Map<String, dynamic>?;
    final patientName = (json['patientName'] ??
            json['patient_name'] ??
            patientObj?['name'] ??
            patientObj?['full_name'] ??
            userObj?['name'] ??
            userObj?['full_name']) as String? ??
        '';

    final fee = (json['serviceFee'] ??
            json['service_fee'] ??
            json['grossAmount'] ??
            json['gross_amount'] ??
            json['fee'] ??
            json['amount'] ??
            json['price'] as num?)
        ?.toDouble() ??
        0.0;

    final comm = (json['platformCommission'] ??
            json['platform_commission'] ??
            json['feesDeducted'] ??
            json['fees_deducted'] ??
            json['commission'] as num?)
        ?.toDouble() ??
        (fee > 0 ? (fee * 0.1) : 0.0);

    final earn = (json['yourEarning'] ??
            json['your_earning'] ??
            json['netIncome'] ??
            json['net_income'] ??
            json['net_amount'] as num?)
        ?.toDouble() ??
        (fee > 0 ? (fee - comm) : 0.0);

    return TransactionModel(
      id: (json['id'] ?? json['transaction_id'] ?? json['_id'] ?? '')
          .toString(),
      patientName: patientName,
      visitType: (json['visitType'] ??
              json['visit_type'] ??
              json['serviceType'] ??
              json['service_type'] ??
              json['type']) as String? ??
          'Checkup',
      status: (json['status'] ?? json['payment_status'] ?? json['state'])
              as String? ??
          'completed',
      date: (json['date'] ?? json['appointment_date'] ?? json['created_at'])
              as String? ??
          '',
      time: (json['time'] ?? json['appointment_time']) as String? ?? '',
      serviceFee: fee,
      platformCommission: comm,
      yourEarning: earn,
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
