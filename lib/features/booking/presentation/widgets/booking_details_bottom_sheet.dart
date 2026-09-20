import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/extensions/time_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../../../../features/auth/data/models/user_type_model.dart';
import '../../data/models/booking_model.dart';
import '../bloc/booking_bloc.dart';
import 'booking_details_info_row.dart';
import 'booking_status_chip.dart';
import 'confirm_booking_cash_payment_dialog.dart';


class BookingDetailsBottomSheet extends StatelessWidget {
  final BookingModel booking;
  final UserType userType;

  const BookingDetailsBottomSheet({
    super.key,
    required this.booking,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    final bool isBranch = booking.type == BookingType.branchVisit;
    final bool isPaid = booking.paymentStatus == PaymentStatus.paid;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 12.h,
        bottom: MediaQuery.paddingOf(context).bottom + 20.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Top Header: Title & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.strings.appointmentDetails,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2D52),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // Ref & Status badges
            Row(
              children: [
                if (booking.bookingRefId != null &&
                    booking.bookingRefId!.isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      booking.bookingRefId!,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF475569),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                ],
                BookingStatusChip(status: booking.status),
              ],
            ),
            SizedBox(height: 20.h),

            // Patient Information Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.patientName ?? '',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F2D52),
                          ),
                        ),
                        if (booking.patientPhone != null &&
                            booking.patientPhone!.isNotEmpty) ...[
                          SizedBox(height: 2.h),
                          Text(
                            booking.patientPhone!,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Booking Details Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  BookingDetailsInfoRow(
                    icon: Icons.science_outlined,
                    label: userType == UserType.radiologyCenter
                        ? context.strings.scanName
                        : (userType == UserType.laboratory
                              ? context.strings.testName
                              : context.strings.services),
                    value: booking.serviceName ?? '',
                  ),
                  SizedBox(height: 12.h),
                  BookingDetailsInfoRow(
                    icon: isBranch
                        ? Icons.business_outlined
                        : Icons.home_work_outlined,
                    label: context.strings.tagBranchVisit,
                    value: isBranch
                        ? context.strings.tagBranchVisit
                        : context.strings.tagHomeVisit,
                  ),
                  if (booking.locationName != null &&
                      booking.locationName!.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    BookingDetailsInfoRow(
                      icon: Icons.location_on_outlined,
                      label: context.strings.location,
                      value: booking.locationName!,
                    ),
                  ],
                  SizedBox(height: 12.h),
                  BookingDetailsInfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: context.strings.appointmentDetails,
                    value: TimeFormatter.formatDateTime(
                      booking.date ?? '',
                      booking.time ?? '',
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Payment Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.strings.paymentStatusLabel,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isPaid ? Colors.green : Colors.orange,
                            ),
                          ),
                          SizedBox(width: 6.w),
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
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        context.strings.feeLabel,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF64748B),
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
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Confirm Cash Payment action if not paid
            if (!isPaid) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => BlocProvider.value(
                        value: context.read<BookingBloc>(),
                        child: ConfirmBookingCashPaymentDialog(booking: booking),
                      ),
                    ).then((confirmed) {
                      if (confirmed == true && context.mounted) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  icon: const Icon(Icons.payments_outlined, color: Colors.white),
                  label: Text(
                    context.strings.confirmCashPayment,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
            ],

            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  context.strings.cancel,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
