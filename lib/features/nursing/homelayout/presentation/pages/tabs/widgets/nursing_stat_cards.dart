import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';
import '../../../../data/models/nursing_dashboard_model.dart';
import 'nursing_stat_card_item.dart';

class NursingStatCards extends StatelessWidget {
  final NursingDashboardModel data;

  const NursingStatCards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: NursingStatCardItem(
                title: strings.todaysBookings.toUpperCase(),
                value: (data.todaysBookings ?? 0).toString(),
                subtitle: data.bookingsTrend ?? '',
                icon: Icons.calendar_today_outlined,
                subtitleColor: const Color(0xFF10B981),
                borderLeftColor: const Color(0xFF0369A1),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: NursingStatCardItem(
                title: strings.activeNurses.toUpperCase(),
                value: (data.activeNurses ?? 0).toString(),
                subtitle: data.activeNursesDesc ?? '',
                icon: Icons.medical_services_outlined,
                subtitleColor: const Color(0xFF64748B),
                borderLeftColor: const Color(0xFF0F766E),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    strings.totalEarnings.toUpperCase(),
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF64748B),
                      letterSpacing: 1.1,
                    ),
                  ),
                  Icon(
                    Icons.monetization_on_outlined,
                    color: const Color(0xFF64748B),
                    size: 20.r,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  NumberFormat.currency(
                    symbol: 'EGP ',
                    decimalDigits: 0,
                  ).format(data.totalEarnings ?? 0),
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2D52),
                    fontSize: 32.sp,
                  ),
                ),
              ),
              if ((data.earningsDesc ?? '').isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  data.earningsDesc!,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
