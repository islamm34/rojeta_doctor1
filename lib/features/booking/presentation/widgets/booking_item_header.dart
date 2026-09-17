import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../../data/models/booking_model.dart';
import 'booking_status_chip.dart';

class BookingItemHeader extends StatelessWidget {
  final BookingModel booking;

  const BookingItemHeader({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final bool isBranch = booking.type == BookingType.branchVisit;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isBranch
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            isBranch
                ? context.strings.tagBranchVisit
                : context.strings.tagHomeVisit,
            style: context.textTheme.labelMedium?.copyWith(
              color: isBranch ? AppColors.primary : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BookingStatusChip(status: booking.status),
      ],
    );
  }
}
