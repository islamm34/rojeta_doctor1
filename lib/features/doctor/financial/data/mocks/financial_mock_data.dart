import '../models/financial_summary_model.dart';
import '../models/transaction_model.dart';

class FinancialMockData {
  static const FinancialSummaryModel summary = FinancialSummaryModel(
    totalIncome: 75200,
    completedAppointments: 245,
    commission: 7520,
    netIncome: 67680,
  );

  static const List<TransactionModel> transactions = [
    TransactionModel(
      patientName: 'Marwan Ali',
      visitType: 'Clinic Visit',
      status: 'completed',
      date: '24 May 2024',
      time: '10:30 AM',
      serviceFee: 500,
      platformCommission: 50,
      yourEarning: 450,
    ),
    TransactionModel(
      patientName: 'Tarek Ahmed',
      visitType: 'Video Call',
      status: 'completed',
      date: '24 May 2024',
      time: '12:00 PM',
      serviceFee: 300,
      platformCommission: 30,
      yourEarning: 270,
    ),
    TransactionModel(
      patientName: 'Nada Hany',
      visitType: 'Clinic Visit',
      status: 'pending',
      date: '25 May 2024',
      time: '01:00 PM',
      serviceFee: 500,
      platformCommission: 50,
      yourEarning: 450,
    ),
    TransactionModel(
      patientName: 'Sayed Kamel',
      visitType: 'Clinic Visit',
      status: 'completed',
      date: '26 May 2024',
      time: '04:30 PM',
      serviceFee: 500,
      platformCommission: 50,
      yourEarning: 450,
    ),
  ];
}
