import 'package:flutter_bloc/flutter_bloc.dart';
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

  void getFinancialData() async {
    emit(state.copyWith(status: FinancialStatus.loading, errorMessage: null));
    
    final summaryResult = await getFinancialSummary();
    final transactionsResult = await getTransactions();

    summaryResult.fold(
      (failure) {
        emit(state.copyWith(
          status: FinancialStatus.failure,
          errorMessage: 'Failed to load financial summary',
        ));
      },
      (summary) {
        transactionsResult.fold(
          (failure) {
            emit(state.copyWith(
              status: FinancialStatus.failure,
              errorMessage: 'Failed to load transactions',
            ));
          },
          (transactions) {
            emit(state.copyWith(
              status: FinancialStatus.success,
              summary: summary,
              transactions: transactions,
            ));
          },
        );
      },
    );
  }
}
