import 'package:flutter/material.dart';

import '../../../../core/utils/screen_util_like.dart';
import '../../../../features/auth/data/models/user_type_model.dart';
import '../../data/models/booking_model.dart';
import 'booking_action_buttons.dart';
import 'booking_item_header.dart';
import 'booking_patient_info.dart';
import 'booking_payment_details.dart';
import 'booking_service_details.dart';

class BookingItemCard extends StatelessWidget {
  final BookingModel booking;
  final UserType userType;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onViewDetails;

  const BookingItemCard({
    super.key,
    required this.booking,
    required this.userType,
    this.onAccept,
    this.onReject,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onViewDetails,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingItemHeader(booking: booking),
            SizedBox(height: 12.h),
            BookingPatientInfo(booking: booking),
            SizedBox(height: 12.h),
            const Divider(),
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: BookingServiceDetails(
                    booking: booking,
                    userType: userType,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: BookingPaymentDetails(booking: booking),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            BookingActionButtons(
              booking: booking,
              onAccept: onAccept,
              onReject: onReject,
              onViewDetails: onViewDetails,
            ),
          ],
        ),
      ),
    );
  }
}
