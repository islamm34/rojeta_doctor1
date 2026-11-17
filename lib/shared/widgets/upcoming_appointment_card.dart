import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/extensions/time_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/doctor_appointment_model.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  final DoctorAppointmentModel appointment;
  final bool isActive;
  final VoidCallback? onTap;

  const UpcomingAppointmentCard({
    super.key,
    required this.appointment,
    this.isActive = false,
    this.onTap,
  });

  String _formatFee(String? rawFee) {
    if (rawFee == null || rawFee.trim().isEmpty) return '';
    final clean = rawFee.trim();
    if (clean.toUpperCase().contains('EGP') || clean.contains('ج.م')) return clean;
    final numVal = double.tryParse(clean);
    if (numVal != null) {
      return 'EGP ${numVal.toStringAsFixed(2)}';
    }
    return 'EGP $clean';
  }

  String _formatDiscount(String? rawDiscount) {
    if (rawDiscount == null || rawDiscount.trim().isEmpty) return '';
    final clean = rawDiscount.trim();
    final numVal = double.tryParse(clean);
    if (numVal != null) {
      if (numVal <= 0) return '';
      return numVal.toStringAsFixed(2);
    }
    if (clean == '0' || clean == '0.00' || clean == '0.0') return '';
    return clean;
  }

  String _formatPaymentMethod(BuildContext context, String? method) {
    if (method == null || method.trim().isEmpty) return context.strings.cash;
    final m = method.trim().toLowerCase();
    if (m.contains('credit') || m.contains('card')) return context.strings.creditCard;
    if (m.contains('cash')) return context.strings.cash;
    if (m.contains('wallet')) return 'محفظة';
    return method;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Status colors
    Color statusBgColor;
    Color statusTextColor;
    if (appointment.status.toLowerCase() == 'confirmed') {
      statusBgColor = Colors.green.withValues(alpha: 0.15);
      statusTextColor = Colors.green.shade700;
    } else if (appointment.status.toLowerCase() == 'pending') {
      statusBgColor = Colors.amber.withValues(alpha: 0.15);
      statusTextColor = Colors.amber.shade800;
    } else {
      statusBgColor = Colors.grey.withValues(alpha: 0.15);
      statusTextColor = Colors.grey.shade700;
    }

    final feeCurrentFormatted = _formatFee(appointment.feeCurrent);
    final feeOriginalFormatted = _formatFee(appointment.feeOriginal);
    final discountFormatted = _formatDiscount(appointment.discount);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isActive ? const Color(0xFF00B4D8) : Colors.grey.shade200,
            width: isActive ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.blue,
                      size: 24.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            appointment.patientName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 16.sp,
                            ),
                          ),
                          if (appointment.isUrgent) ...[
                            SizedBox(width: 6.w),
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.workspace_premium,
                                color: Colors.amber.shade700,
                                size: 14.sp,
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            appointment.patientPhone ?? '',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.phone_outlined,
                            size: 14.sp,
                            color: Colors.grey.shade500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    appointment.status.toLowerCase(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: statusTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Time & Date Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.access_time,
                              size: 14.sp,
                              color: Colors.blue.shade400,
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          appointment.appointmentTime.formatTo12Hour(context),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 14.sp,
                              color: Colors.purple.shade400,
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          TimeFormatter.formatDate(
                            appointment.appointmentDate,
                            context: context,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Location
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.orange.shade50.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.sp,
                        color: Colors.orange.shade400,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    appointment.location ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Notes (Optional)
            if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.amber.shade200, width: 0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        appointment.notes!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.amber.shade900,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.description_outlined,
                      size: 16.sp,
                      color: Colors.amber.shade700,
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: 12.h),

            // Fee and Payment Row
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.green.shade50.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.strings.feeLabel,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6.w,
                          runSpacing: 2.h,
                          children: [
                            if (discountFormatted.isNotEmpty &&
                                feeOriginalFormatted.isNotEmpty &&
                                feeOriginalFormatted != feeCurrentFormatted)
                              Text(
                                feeOriginalFormatted,
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12.sp,
                                ),
                              ),
                            Text(
                              feeCurrentFormatted.isNotEmpty
                                  ? feeCurrentFormatted
                                  : 'EGP 0.00',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                            if (discountFormatted.isNotEmpty &&
                                feeOriginalFormatted != feeCurrentFormatted) ...[
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  discountFormatted,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Text(
                      _formatPaymentMethod(context, appointment.paymentMethod),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.orange.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
