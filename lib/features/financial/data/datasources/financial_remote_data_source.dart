import '../../../../core/local/user_hive_helper.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/endpoints.dart';
import '../../../../core/utils/extensions/time_extensions.dart';
import '../models/financial_summary_model.dart';
import '../models/transaction_model.dart';

abstract class FinancialRemoteDataSource {
  Future<FinancialSummaryModel> getFinancialSummary({
    String? period,
    String? startDate,
    String? endDate,
  });

  Future<List<TransactionModel>> getTransactions({
    int? page,
    int? limit,
    String? status,
    String? period,
    String? startDate,
    String? endDate,
  });
}

class FinancialRemoteDataSourceImpl implements FinancialRemoteDataSource {
  final ApiConsumer apiConsumer;

  FinancialRemoteDataSourceImpl({required this.apiConsumer});

  DateTime? _extractDate(dynamic raw) {
    if (raw == null) return null;
    if (raw is DateTime) return raw;
    final str = TimeFormatter.toAsciiDigits(raw.toString().trim());
    if (str.isEmpty) return null;

    final parsedIso = DateTime.tryParse(str.replaceAll(' ', 'T'));
    if (parsedIso != null) return parsedIso;

    // dd-MM-yyyy or dd/MM/yyyy: e.g. 09-11-2026, 30-10-2026
    final dmy = RegExp(r'^(\d{1,2})[-/](\d{1,2})[-/](\d{4})').firstMatch(str);
    if (dmy != null) {
      final d = int.tryParse(dmy.group(1)!);
      final m = int.tryParse(dmy.group(2)!);
      final y = int.tryParse(dmy.group(3)!);
      if (d != null && m != null && y != null) return DateTime(y, m, d);
    }

    // yyyy-MM-dd or yyyy/MM/dd: e.g. 2026-10-30
    final ymd = RegExp(r'^(\d{4})[-/](\d{1,2})[-/](\d{1,2})').firstMatch(str);
    if (ymd != null) {
      final y = int.tryParse(ymd.group(1)!);
      final m = int.tryParse(ymd.group(2)!);
      final d = int.tryParse(ymd.group(3)!);
      if (y != null && m != null && d != null) return DateTime(y, m, d);
    }

    return null;
  }

  bool _isItemInPeriod(
    Map<String, dynamic> item,
    String? period, {
    String? startDate,
    String? endDate,
  }) {
    if (period == null || period.isEmpty || period.toLowerCase() == 'all') {
      return true;
    }

    final datesToCheck = <DateTime>[];

    void addIfValid(dynamic raw) {
      if (raw == null) return;
      final parsed = _extractDate(raw);
      if (parsed != null) datesToCheck.add(parsed);
    }

    addIfValid(item['payment_date'] ?? item['paymentDate']);
    addIfValid(item['paid_at'] ?? item['paidAt']);
    addIfValid(item['created_at'] ?? item['createdAt']);
    addIfValid(item['updated_at'] ?? item['updatedAt']);
    addIfValid(item['appointment_date'] ?? item['appointmentDate']);
    addIfValid(item['booking_date'] ?? item['bookingDate']);
    addIfValid(item['date']);

    if (datesToCheck.isEmpty) {
      return period.toLowerCase() != 'today';
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (period.toLowerCase()) {
      case 'today':
        return datesToCheck.any((d) {
          final target = DateTime(d.year, d.month, d.day);
          return target.isAtSameMomentAs(today);
        });
      case 'week':
        final weekAgo = today.subtract(const Duration(days: 7));
        return datesToCheck.any((d) {
          final target = DateTime(d.year, d.month, d.day);
          return !target.isBefore(weekAgo) && !target.isAfter(today);
        });
      case 'month':
        final monthAgo = today.subtract(const Duration(days: 30));
        return datesToCheck.any((d) {
          final target = DateTime(d.year, d.month, d.day);
          return !target.isBefore(monthAgo) && !target.isAfter(today);
        });
      default:
        return true;
    }
  }

  @override
  Future<FinancialSummaryModel> getFinancialSummary({
    String? period,
    String? startDate,
    String? endDate,
  }) async {
    final cleanPeriod = period?.trim().toLowerCase();
    final isSpecificPeriod = cleanPeriod != null &&
        cleanPeriod.isNotEmpty &&
        cleanPeriod != 'all';

    if (isSpecificPeriod) {
      final summary = await _calculateSummaryFromAppointments(
        period: period,
        startDate: startDate,
        endDate: endDate,
      );
      if (summary.totalIncome > 0 || summary.completedAppointments > 0) {
        return summary;
      }
    }

    try {
      final response = await apiConsumer.get(Endpoints.financialSummary);

      final data = response is Map<String, dynamic> && response['data'] != null
          ? (response['data'] is Map<String, dynamic>
                ? response['data'] as Map<String, dynamic>
                : response)
          : (response is Map<String, dynamic> ? response : <String, dynamic>{});

      final parsed = FinancialSummaryModel.fromJson(data);
      if (parsed.totalIncome > 0 || parsed.completedAppointments > 0) {
        return parsed;
      }
    } catch (_) {
      // Fallback only if financial summary endpoint fails or returns zero
    }

    return _calculateSummaryFromAppointments(
      period: period,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<FinancialSummaryModel> _calculateSummaryFromAppointments({
    String? period,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final role = UserHiveHelper.getUser()?.role?.toLowerCase().trim() ?? '';
      final isHospital = role.contains('hospital');
      final allItems = <Map<String, dynamic>>[];

      final endpoint = isHospital
          ? Endpoints.hospitalAppointments
          : Endpoints.doctorAppointments;

      try {
        final apptResponse = await apiConsumer.get(endpoint);
        List<dynamic> rawList = [];
        if (apptResponse is List) {
          rawList = apptResponse;
        } else if (apptResponse is Map<String, dynamic>) {
          if (apptResponse['data'] is List) {
            rawList = apptResponse['data'] as List<dynamic>;
          } else if (apptResponse['data'] is Map<String, dynamic> &&
              apptResponse['data']['data'] is List) {
            rawList = apptResponse['data']['data'] as List<dynamic>;
          }
        }
        allItems.addAll(rawList.whereType<Map<String, dynamic>>());
      } catch (_) {
        try {
          final bResponse = await apiConsumer.get(Endpoints.bookings);
          List<dynamic> rawList = [];
          if (bResponse is List) {
            rawList = bResponse;
          } else if (bResponse is Map<String, dynamic>) {
            if (bResponse['data'] is List) {
              rawList = bResponse['data'] as List<dynamic>;
            } else if (bResponse['data'] is Map<String, dynamic> &&
                bResponse['data']['data'] is List) {
              rawList = bResponse['data']['data'] as List<dynamic>;
            }
          }
          allItems.addAll(rawList.whereType<Map<String, dynamic>>());
        } catch (_) {}
      }

      double total = 0;
      int completed = 0;
      for (final item in allItems) {
        if (!_isItemInPeriod(
          item,
          period,
          startDate: startDate,
          endDate: endDate,
        )) {
          continue;
        }

        final status = (item['status'] ?? item['appointment_status'] ?? '')
            .toString()
            .toLowerCase();
        final paymentStatus =
            (item['payment_status'] ??
                    item['paymentStatus'] ??
                    item['payment_type'] ??
                    '')
                .toString()
                .toLowerCase();
        final isExplicitlyUnpaid =
            paymentStatus == 'unpaid' ||
            paymentStatus == 'غير مدفوع' ||
            paymentStatus == 'not_paid';

        final paymentMethod = (item['payment_method'] ??
                item['paymentMethod'] ??
                item['payment_type'] ??
                '')
            .toString()
            .toLowerCase();
        final isCash =
            paymentMethod.contains('cash') || paymentMethod.contains('نقدي');

        final isPaid = paymentStatus == 'paid' ||
            paymentStatus == 'مدفوع' ||
            paymentStatus == 'confirmed' ||
            status == 'paid';
        final isCompleted = status == 'completed' || status == 'مكتمل';

        // For cash payments, the doctor must confirm payment. For non-cash, paid or completed counts.
        final bool isEarned;
        if (isCash) {
          isEarned = isPaid;
        } else {
          isEarned = !isExplicitlyUnpaid && (isPaid || isCompleted);
        }

        if (isEarned) {
          completed++;
          final rawFee =
              item['fee_current'] ??
              item['feeCurrent'] ??
              item['fee_original'] ??
              item['feeOriginal'] ??
              item['total_price'] ??
              item['totalPrice'] ??
              item['price'] ??
              item['fee'] ??
              item['amount'] ??
              item['service_fee'] ??
              item['total_amount'];
          final fee = (rawFee is num)
              ? rawFee.toDouble()
              : (rawFee is String
                    ? (double.tryParse(
                            rawFee.replaceAll(RegExp(r'[^0-9.]'), ''),
                          ) ??
                          0.0)
                    : 0.0);
          total += fee;
        }
      }

      final comm = total * 0.1;
      return FinancialSummaryModel(
        totalIncome: total,
        completedAppointments: completed,
        commission: comm,
        netIncome: total - comm,
      );
    } catch (_) {
      return const FinancialSummaryModel(
        totalIncome: 0.0,
        completedAppointments: 0,
        commission: 0.0,
        netIncome: 0.0,
      );
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions({
    int? page,
    int? limit,
    String? status,
    String? period,
    String? startDate,
    String? endDate,
  }) async {
    final query = <String, dynamic>{};
    if (page != null) query['page'] = page;
    if (limit != null) query['limit'] = limit;
    if (status != null && status.isNotEmpty) query['status'] = status;
    if (period != null && period.isNotEmpty) query['period'] = period;
    if (startDate != null && startDate.isNotEmpty) {
      query['startDate'] = startDate;
      query['start_date'] = startDate;
    }
    if (endDate != null && endDate.isNotEmpty) {
      query['endDate'] = endDate;
      query['end_date'] = endDate;
    }

    try {
      final response = await apiConsumer.get(
        Endpoints.financialTransactions,
        queryParameters: query.isNotEmpty ? query : null,
      );

      List<dynamic> rawList = [];
      if (response is List) {
        rawList = response;
      } else if (response is Map<String, dynamic>) {
        if (response['data'] is List) {
          rawList = response['data'] as List<dynamic>;
        } else if (response['data'] is Map<String, dynamic> &&
            response['data']['data'] is List) {
          rawList = response['data']['data'] as List<dynamic>;
        }
      }

      return rawList
          .whereType<Map<String, dynamic>>()
          .where(
            (e) => _isItemInPeriod(
              e,
              period,
              startDate: startDate,
              endDate: endDate,
            ),
          )
          .map((e) => TransactionModel.fromJson(e))
          .toList();
    } catch (_) {
      // Fallback below
    }

    // Fallback: synthesize transactions from appointments (for doctor) or bookings (for provider)
    try {
      final role = UserHiveHelper.getUser()?.role?.toLowerCase().trim() ?? '';
      final isDoctor = role == 'doctor' || role.contains('doctor');
      final isHospital = role == 'hospital' || role.contains('hospital');
      final allItems = <Map<String, dynamic>>[];

      if (isDoctor || isHospital) {
        try {
          final endpoint = isHospital
              ? Endpoints.hospitalAppointments
              : Endpoints.doctorAppointments;
          final apptResponse = await apiConsumer.get(endpoint);
          List<dynamic> rawList = [];
          if (apptResponse is List) {
            rawList = apptResponse;
          } else if (apptResponse is Map<String, dynamic>) {
            if (apptResponse['data'] is List) {
              rawList = apptResponse['data'] as List<dynamic>;
            } else if (apptResponse['data'] is Map<String, dynamic> &&
                apptResponse['data']['data'] is List) {
              rawList = apptResponse['data']['data'] as List<dynamic>;
            }
          }
          allItems.addAll(rawList.whereType<Map<String, dynamic>>());
        } catch (_) {}
      } else {
        try {
          final bResponse = await apiConsumer.get(Endpoints.bookings);
          List<dynamic> rawList = [];
          if (bResponse is List) {
            rawList = bResponse;
          } else if (bResponse is Map<String, dynamic>) {
            if (bResponse['data'] is List) {
              rawList = bResponse['data'] as List<dynamic>;
            } else if (bResponse['data'] is Map<String, dynamic> &&
                bResponse['data']['data'] is List) {
              rawList = bResponse['data']['data'] as List<dynamic>;
            }
          }
          allItems.addAll(rawList.whereType<Map<String, dynamic>>());
        } catch (_) {}
      }

      final periodItems = allItems.where((item) {
        return _isItemInPeriod(
          item,
          period,
          startDate: startDate,
          endDate: endDate,
        );
      }).toList();

      final paidOrCompleted = periodItems.where((item) {
        final status =
            (item['status'] ??
                    item['appointment_status'] ??
                    item['booking_status'] ??
                    '')
                .toString()
                .toLowerCase();
        final pStatus = (item['payment_status'] ?? item['paymentStatus'] ?? '')
            .toString()
            .toLowerCase();
        final isExplicitlyUnpaid =
            pStatus == 'unpaid' ||
            pStatus == 'غير مدفوع' ||
            pStatus == 'not_paid';
        return !isExplicitlyUnpaid &&
            (status == 'completed' ||
                status == 'paid' ||
                status == 'مكتمل' ||
                pStatus == 'paid' ||
                pStatus == 'مدفوع' ||
                pStatus == 'confirmed');
      }).toList();

      final listToUse = paidOrCompleted.isNotEmpty
          ? paidOrCompleted
          : periodItems;
      return listToUse.map((e) => TransactionModel.fromJson(e)).toList();
    } catch (_) {
      return <TransactionModel>[];
    }
  }
}
