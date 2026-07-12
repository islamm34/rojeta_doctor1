import 'package:flutter_bloc/flutter_bloc.dart';
import 'financial_state.dart';
import '../../data/mocks/financial_mock_data.dart';

class FinancialCubit extends Cubit<FinancialState> {
  FinancialCubit() : super(const FinancialState());

  void getFinancialData() async {
    emit(state.copyWith(status: FinancialStatus.loading, errorMessage: null));
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    emit(state.copyWith(
      status: FinancialStatus.success,
      summary: FinancialMockData.summary,
      transactions: FinancialMockData.transactions,
    ));
  }
}
