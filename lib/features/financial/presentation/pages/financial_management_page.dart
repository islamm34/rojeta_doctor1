import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/di/injector.dart';
import '../bloc/financial_cubit.dart';
import '../bloc/financial_state.dart';
import '../widgets/period_toggle_buttons.dart';
import '../widgets/net_income_card.dart';
import '../widgets/breakdown_section.dart';
import '../widgets/transaction_history_section.dart';
import '../widgets/payment_schedule_info.dart';

class FinancialManagementPage extends StatelessWidget {
  const FinancialManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          injector<FinancialCubit>()..getFinancialData(period: 'today'),
      child: Scaffold(
        backgroundColor: const Color(
          0xFFF5F9FC,
        ), // Consistent background with app_colors
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.pop(),
          ),
          title: Text(
            context.strings.financialManagement,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<FinancialCubit, FinancialState>(
          builder: (context, state) {
            if (state.status == FinancialStatus.loading ||
                state.status == FinancialStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == FinancialStatus.failure) {
              return Center(
                child: Text(
                  state.errorMessage ?? 'Error loading financial data',
                ),
              );
            }

            final summary = state.summary;
            final transactions = state.transactions;

            if (summary == null) {
              return const SizedBox.shrink();
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<FinancialCubit>().getFinancialData(
                  period: state.selectedPeriod,
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PeriodToggleButtons(
                      selectedPeriod: state.selectedPeriod,
                      onPeriodChanged: (period) {
                        context.read<FinancialCubit>().getFinancialData(
                          period: period,
                        );
                      },
                    ),
                    NetIncomeCard(summary: summary),
                    BreakdownSection(summary: summary),
                    if (transactions.isNotEmpty)
                      TransactionHistorySection(transactions: transactions),
                    const PaymentScheduleInfo(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
