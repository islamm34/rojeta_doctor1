import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/models/hospital_dashboard_model.dart';
import 'hospital_stat_card.dart';

class HospitalHomeStatsGrid extends StatelessWidget {
  final HospitalDashboardModel? data;

  const HospitalHomeStatsGrid({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final doctorsCount = data?.doctorsCount ?? 0;
    final income = data?.todaysIncome ?? 0.0;
    final appointmentsCount = data?.appointmentsCount ?? 0;

    final incomeText = income > 0
        ? '${income.toStringAsFixed(0)} ${context.strings.egp}'
        : '0 ${context.strings.egp}';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HospitalStatCard(
            icon: Icons.medical_services_outlined,
            title: context.strings.doctors,
            value: doctorsCount.toString(),
          ),
          SizedBox(width: 8.w),
          HospitalStatCard(
            icon: Icons.payments_outlined,
            title: context.strings.todaysIncome,
            value: incomeText,
          ),
          SizedBox(width: 8.w),
          HospitalStatCard(
            icon: Icons.calendar_month_outlined,
            title: context.strings.appointments,
            value: appointmentsCount.toString(),
          ),
        ],
      ),
    );
  }
}
