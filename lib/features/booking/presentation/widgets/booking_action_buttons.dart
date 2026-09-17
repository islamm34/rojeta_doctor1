import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../../data/models/booking_model.dart';

class BookingActionButtons extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onViewDetails;

  const BookingActionButtons({
    super.key,
    required this.booking,
    this.onAccept,
    this.onReject,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (booking.status != BookingStatus.pending) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onViewDetails,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h),
          ),
          child: Text(
            context.strings.viewDetailsBtn,
            style: context.textTheme.labelLarge?.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onReject,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Text(
              context.strings.rejectBtn,
              style: context.textTheme.labelLarge?.copyWith(color: Colors.red),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton(
            onPressed: onAccept,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Text(
              context.strings.acceptBtn,
              style: context.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
