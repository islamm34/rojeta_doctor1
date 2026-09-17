import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/extensions/time_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../../../../features/auth/data/models/user_type_model.dart';
import '../../data/models/booking_model.dart';

class BookingServiceDetails extends StatelessWidget {
  final BookingModel booking;
  final UserType userType;

  const BookingServiceDetails({
    super.key,
    required this.booking,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    final hasLocation = booking.type == BookingType.branchVisit &&
        booking.locationName != null &&
        booking.locationName!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.science_outlined, size: 16.sp, color: Colors.grey[600]),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                userType == UserType.radiologyCenter
                    ? context.strings.scanTypeLabel
                    : (userType == UserType.laboratory
                          ? context.strings.testName
                          : 'Service Name'),
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Text(
            booking.serviceName ?? '',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        if (hasLocation) ...[
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: Colors.grey[600],
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  booking.locationName!,
                  style: context.textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 16.sp,
              color: Colors.grey[600],
            ),
            SizedBox(width: 8.w),
            Text(
              TimeFormatter.formatDateTime(
                booking.date ?? '',
                booking.time ?? '',
                context: context,
              ),
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
