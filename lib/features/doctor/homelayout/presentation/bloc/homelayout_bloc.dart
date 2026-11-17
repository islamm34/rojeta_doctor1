import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/core/error/exceptions.dart';
import 'package:rojeta_doctor/core/error/failures.dart';
import 'package:rojeta_doctor/core/local/user_hive_helper.dart';
import 'package:rojeta_doctor/features/financial/data/models/financial_summary_model.dart';
import 'package:rojeta_doctor/features/financial/domain/repositories/financial_repository.dart';
import '../../data/models/doctor_dashboard_stats.dart';
import '../../data/models/doctor_appointment_model.dart';
import '../../data/models/doctor_profile_model.dart';
import '../../data/repositories/doctor_appointments_repository.dart';
import '../../data/repositories/doctor_dashboard_repository.dart';
import 'homelayout_event.dart';
import 'homelayout_state.dart';

class HomelayoutBloc extends Bloc<HomelayoutEvent, HomelayoutState> {
  final DoctorDashboardRepository dashboardRepository;
  final DoctorAppointmentsRepository appointmentsRepository;
  final FinancialRepository? financialRepository;

  HomelayoutBloc({
    required this.dashboardRepository,
    required this.appointmentsRepository,
    this.financialRepository,
  }) : super(const HomelayoutState()) {
    on<LoadHomelayoutEvent>(_onLoad);
  }

  FutureOr<void> _onLoad(
    LoadHomelayoutEvent event,
    Emitter<HomelayoutState> emit,
  ) async {
    emit(state.copyWith(status: HomelayoutStatus.loading, errorMessage: null));
    try {
      final finRepo =
          financialRepository ??
          (injector.isRegistered<FinancialRepository>()
              ? injector<FinancialRepository>()
              : null);

      final futures = <Future<dynamic>>[
        dashboardRepository.getDashboardStats(),
        dashboardRepository.getProfileSummary(),
        appointmentsRepository.getAppointments(limit: 5),
        if (finRepo != null) finRepo.getFinancialSummary(period: 'today'),
      ];

      final results = await Future.wait(futures);

      var stats = results[0] as DoctorDashboardStats?;
      var profileSummary = results[1] as DoctorProfileModel?;
      final rawAppointments =
          results[2] as List<DoctorAppointmentModel>? ?? const [];

      if (finRepo != null && results.length > 3) {
        final finEither = results[3] as Either<Failure, FinancialSummaryModel>?;
        if (finEither != null) {
          finEither.fold(
            (_) {},
            (finSummary) {
              final currentStats = stats;
              if (currentStats != null) {
                final amount = finSummary.netIncome > 0
                    ? finSummary.netIncome
                    : finSummary.totalIncome;
                if (amount > 0) {
                  final formatted = amount % 1 == 0
                      ? amount.toInt().toString()
                      : amount.toStringAsFixed(1);
                  stats = currentStats.copyWith(todayIncome: formatted);
                }
              }
            },
          );
        }
      }

      // If backend returned todayAppointments == 0, but there are new requests/appointments today:
      if (stats != null && stats!.todayAppointments == 0) {
        if (stats!.newRequests > 0) {
          stats = stats!.copyWith(todayAppointments: stats!.newRequests);
        } else if (rawAppointments.isNotEmpty) {
          stats = stats!.copyWith(todayAppointments: rawAppointments.length);
        }
      }

      final cachedUser = UserHiveHelper.getUser();
      final userKey = cachedUser?.id?.toString() ?? cachedUser?.phone ?? '';
      final savedImg =
          (cachedUser?.image != null && cachedUser!.image!.trim().isNotEmpty)
          ? cachedUser.image!.trim()
          : (UserHiveHelper.getUserImage(userKey) ??
                UserHiveHelper.getDoctorImage(userKey) ??
                UserHiveHelper.getDoctorImage('latest') ??
                '');

      if (savedImg.isNotEmpty) {
        if (profileSummary != null && profileSummary.imageUrl.trim().isEmpty) {
          profileSummary = profileSummary.copyWith(imageUrl: savedImg);
        }
        if (cachedUser != null &&
            (cachedUser.image == null || cachedUser.image!.trim().isEmpty)) {
          cachedUser.image = savedImg;
          UserHiveHelper.saveUser(cachedUser);
        }
      }

      final activeUpcoming = rawAppointments.where((a) {
        final norm = DoctorAppointmentModel.normalizeStatus(
          a.status,
        ).toLowerCase();
        return norm == 'pending' || norm == 'confirmed';
      }).toList();

      emit(
        state.copyWith(
          status: HomelayoutStatus.success,
          stats: stats,
          profileSummary: profileSummary,
          upcomingAppointments: activeUpcoming.isNotEmpty
              ? activeUpcoming
              : rawAppointments,
        ),
      );
    } catch (e) {
      final errorMessage = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(
        state.copyWith(
          status: HomelayoutStatus.failure,
          errorMessage: errorMessage,
        ),
      );
    }
  }
}
