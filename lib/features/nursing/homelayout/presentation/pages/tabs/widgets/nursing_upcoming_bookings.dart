import 'package:flutter/material.dart';

import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/extensions/time_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';
import '../../../../data/models/nursing_dashboard_model.dart';

class NursingUpcomingBookings extends StatelessWidget {
  final List<NursingBookingModel> bookings;

  const NursingUpcomingBookings({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Text(
            strings.noUpcomingBookings,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF64748B),
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: bookings.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF), // Light Blue
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      booking.dateMonth ?? '',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: const Color(0xFF3B82F6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      booking.dateDay ?? '',
                      style: context.textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF1E3A8A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            booking.patientName ?? '',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F2D52),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if ((booking.time ?? '').isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              (booking.time ?? '').formatTo12Hour(context),
                              style: context.textTheme.labelSmall?.copyWith(
                                color: const Color(0xFF065F46),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking.serviceType ?? '',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14.r,
                          color: const Color(0xFF94A3B8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
