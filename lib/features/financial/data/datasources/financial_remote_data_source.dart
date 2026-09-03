import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/endpoints.dart';
import '../models/financial_summary_model.dart';
import '../models/transaction_model.dart';

abstract class FinancialRemoteDataSource {
  Future<FinancialSummaryModel> getFinancialSummary({
    String? startDate,
    String? endDate,
  });

  Future<List<TransactionModel>> getTransactions({
    int? page,
    int? limit,
    String? status,
    String? startDate,
    String? endDate,
  });
}

class FinancialRemoteDataSourceImpl implements FinancialRemoteDataSource {
  final ApiConsumer apiConsumer;

  FinancialRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<FinancialSummaryModel> getFinancialSummary({
    String? startDate,
    String? endDate,
  }) async {
    final query = <String, dynamic>{};
    if (startDate != null && startDate.isNotEmpty) {
      query['startDate'] = startDate;
    }
    if (endDate != null && endDate.isNotEmpty) {
      query['endDate'] = endDate;
    }

    final response = await apiConsumer.get(
      Endpoints.financialSummary,
      queryParameters: query.isNotEmpty ? query : null,
    );

    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});

    return FinancialSummaryModel.fromJson(data);
  }

  @override
  Future<List<TransactionModel>> getTransactions({
    int? page,
    int? limit,
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    final query = <String, dynamic>{};
    if (page != null) query['page'] = page;
    if (limit != null) query['limit'] = limit;
    if (status != null && status.isNotEmpty) query['status'] = status;
    if (startDate != null && startDate.isNotEmpty) {
      query['startDate'] = startDate;
    }
    if (endDate != null && endDate.isNotEmpty) {
      query['endDate'] = endDate;
    }

    final response = await apiConsumer.get(
      Endpoints.financialTransactions,
      queryParameters: query.isNotEmpty ? query : null,
    );

    final rawList = response is Map<String, dynamic> && response['data'] is List
        ? response['data'] as List<dynamic>
        : (response is List ? response : <dynamic>[]);

    return rawList
        .whereType<Map<String, dynamic>>()
        .map((e) => TransactionModel.fromJson(e))
        .toList();
  }
}
