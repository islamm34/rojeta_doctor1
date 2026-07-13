import 'package:flutter/material.dart';
import '../../../../features/auth/data/models/user_type_model.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import '../../data/models/booking_model.dart';

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
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 12.h),
          _buildPatientInfo(context),
          SizedBox(height: 12.h),
          const Divider(),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildServiceDetails(context)),
              Expanded(flex: 2, child: _buildPaymentDetails(context)),
            ],
          ),
          SizedBox(height: 16.h),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final bool isBranch = booking.type == BookingType.branchVisit;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isBranch ? AppColors.primary.withOpacity(0.1) : Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            isBranch ? context.strings.tagBranchVisit : context.strings.tagHomeVisit,
            style: context.textTheme.labelMedium?.copyWith(
              color: isBranch ? AppColors.primary : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildStatusChip(context),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color bgColor;
    Color textColor;
    String label;

    switch (booking.status) {
      case BookingStatus.pending:
        bgColor = AppColors.pendingIconBg;
        textColor = AppColors.pendingIcon;
        label = context.strings.pendingBookings;
        break;
      case BookingStatus.confirmed:
        bgColor = AppColors.incomeIconBg;
        textColor = AppColors.incomeIcon;
        label = context.strings.filterConfirmed;
        break;
      case BookingStatus.completed:
        bgColor = AppColors.completedIconBg;
        textColor = AppColors.completedIcon;
        label = context.strings.filterCompleted;
        break;
      case BookingStatus.rejected:
        bgColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        label = context.strings.filterRejected;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPatientInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          booking.patientName,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          booking.patientPhone,
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.science_outlined, size: 16.sp, color: Colors.grey[600]),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                userType == UserType.radiologyCenter ? context.strings.scanTypeLabel : (userType == UserType.laboratory ? context.strings.testName : 'Service Name'),
                style: context.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Text(
            booking.serviceName,
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8.h),
        if (booking.type == BookingType.branchVisit && booking.locationName.isNotEmpty) ...[
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 16.sp, color: Colors.grey[600]),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  booking.locationName,
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
            Icon(Icons.calendar_today_outlined, size: 16.sp, color: Colors.grey[600]),
            SizedBox(width: 8.w),
            Text(
              '${booking.date} - ${booking.time}',
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentDetails(BuildContext context) {
    final bool isPaid = booking.paymentStatus == PaymentStatus.paid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          context.strings.paymentStatusLabel,
          style: context.textTheme.labelSmall?.copyWith(color: Colors.grey[600]),
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
              isPaid ? context.strings.paymentPaid : context.strings.paymentPending,
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
          style: context.textTheme.labelSmall?.copyWith(color: Colors.grey[600]),
        ),
        SizedBox(height: 4.h),
        Text(
          '${booking.fee} ${context.strings.priceEgp.split(' ').last.replaceAll('(', '').replaceAll(')', '')}', // Extracting 'EGP' or 'جنيه' from translation
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    if (booking.status == BookingStatus.completed || booking.status == BookingStatus.rejected) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onViewDetails,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            padding: EdgeInsets.symmetric(vertical: 12.h),
          ),
          child: Text(
            context.strings.viewDetailsBtn,
            style: context.textTheme.labelLarge?.copyWith(color: AppColors.primary),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Text(
              context.strings.acceptBtn,
              style: context.textTheme.labelLarge?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
