import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_dashboard_model.dart';
import 'package:intl/intl.dart';

class NursingStatCards extends StatelessWidget {
  final NursingDashboardModel data;

  const NursingStatCards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context: context,
                title: "TODAY'S BOOKINGS",
                value: data.todaysBookings.toString(),
                subtitle: data.bookingsTrend,
                icon: Icons.calendar_today_outlined,
                subtitleColor: const Color(0xFF10B981),
                borderLeftColor: const Color(0xFF0369A1),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                context: context,
                title: 'ACTIVE NURSES',
                value: data.activeNurses.toString(),
                subtitle: data.activeNursesDesc,
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
                color: Colors.black.withOpacity(0.02),
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
                    'TOTAL EARNINGS',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF64748B),
                      letterSpacing: 1.1,
                    ),
                  ),
                  Icon(Icons.monetization_on_outlined, color: const Color(0xFF64748B), size: 20.r),
                ],
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  NumberFormat.currency(symbol: '\$', decimalDigits: 0).format(data.totalEarnings),
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2D52),
                    fontSize: 32.sp,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                data.earningsDesc,
                style: context.textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color subtitleColor,
    required Color borderLeftColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: -12.w,
            top: -12.w,
            bottom: -12.w,
            child: Container(
              width: 4.w,
              color: borderLeftColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF64748B),
                        letterSpacing: 1.0,
                        fontSize: 10.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(icon, color: const Color(0xFF64748B), size: 16.r),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                value,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: borderLeftColor,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  if (subtitle.contains('+'))
                    Icon(Icons.trending_up, color: subtitleColor, size: 12.r),
                  if (subtitle.contains('+')) SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      subtitle,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: subtitleColor,
                        fontSize: 10.sp,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
