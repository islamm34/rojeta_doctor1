import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'financial_state.dart';
import '../../domain/usecases/get_financial_summary_usecase.dart';
import '../../domain/usecases/get_transactions_usecase.dart';

class FinancialCubit extends Cubit<FinancialState> {
  final GetFinancialSummaryUseCase getFinancialSummary;
  final GetTransactionsUseCase getTransactions;

  FinancialCubit({
    required this.getFinancialSummary,
    required this.getTransactions,
  }) : super(const FinancialState());

  void getFinancialData({String? period}) async {
    final activePeriod = period ?? state.selectedPeriod;
    emit(state.copyWith(
      status: FinancialStatus.loading,
      errorMessage: null,
      selectedPeriod: activePeriod,
    ));

    final now = DateTime.now();
    final todayStr = DateFormat('yyyy-MM-dd').format(now);
    String? startDate;
    String? endDate = todayStr;

    if (activePeriod == 'today') {
      startDate = todayStr;
    } else if (activePeriod == 'week') {
      final weekAgo = now.subtract(const Duration(days: 7));
      startDate = DateFormat('yyyy-MM-dd').format(weekAgo);
    } else if (activePeriod == 'month') {
      final monthAgo = now.subtract(const Duration(days: 30));
      startDate = DateFormat('yyyy-MM-dd').format(monthAgo);
    }

    final summaryResult = await getFinancialSummary(
      period: activePeriod,
      startDate: startDate,
      endDate: endDate,
    );
    final transactionsResult = await getTransactions(
      period: activePeriod,
      startDate: startDate,
      endDate: endDate,
    );

    summaryResult.fold(
      (failure) {
        emit(state.copyWith(
          status: FinancialStatus.failure,
          errorMessage: 'Failed to load financial summary',
          selectedPeriod: activePeriod,
        ));
      },
      (summary) {
        transactionsResult.fold(
          (failure) {
            emit(state.copyWith(
              status: FinancialStatus.failure,
              errorMessage: 'Failed to load transactions',
              selectedPeriod: activePeriod,
            ));
          },
          (transactions) {
            emit(state.copyWith(
              status: FinancialStatus.success,
              summary: summary,
              transactions: transactions,
              selectedPeriod: activePeriod,
            ));
          },
        );
      },
    );
  }
}
