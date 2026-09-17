import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../../data/models/booking_model.dart';

class BookingPaymentDetails extends StatelessWidget {
  final BookingModel booking;

  const BookingPaymentDetails({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final bool isPaid = booking.paymentStatus == PaymentStatus.paid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          context.strings.paymentStatusLabel,
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isPaid ? Colors.green : Colors.orange,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              isPaid
                  ? context.strings.paymentPaid
                  : context.strings.paymentPending,
              style: context.textTheme.bodyMedium?.copyWith(
                color: isPaid ? Colors.green : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          context.strings.feeLabel,
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '${booking.fee ?? 0} ${context.strings.priceEgp.split(' ').last.replaceAll('(', '').replaceAll(')', '')}',
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
