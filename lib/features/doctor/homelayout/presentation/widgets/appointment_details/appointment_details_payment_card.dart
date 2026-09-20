import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/doctor_appointment_details_model.dart';
import '../../bloc/appointment_details/appointment_details_bloc.dart';
import 'confirm_cash_payment_dialog.dart';

class AppointmentDetailsPaymentCard extends StatelessWidget {
  final DoctorAppointmentDetailsModel details;

  const AppointmentDetailsPaymentCard({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isPaid = details.paymentStatus?.toLowerCase() == 'paid';
    final paymentStatusLabel = isPaid
        ? context.strings.paid
        : context.strings.unpaid;

    String formatPaymentMethod(String? method) {
      if (method == null || method.isEmpty) return '-';
      final lower = method.toLowerCase();
      if (lower.contains('credit') || lower.contains('card')) {
        return context.strings.creditCard;
      } else if (lower.contains('cash')) {
        return context.strings.cash;
      }
      return method;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.strings.paymentDetails,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 15.sp,
                ),
              ),
              if (details.paymentStatus != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: isPaid ? Colors.green.shade50 : Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    paymentStatusLabel,
                    style: TextStyle(
                      color: isPaid
                          ? Colors.green.shade700
                          : Colors.amber.shade900,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.strings.paymentMethod,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      formatPaymentMethod(details.paymentMethod),
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (details.feeOriginal != null &&
                  details.feeOriginal!.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.strings.feeOriginal,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        details.feeOriginal!,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.strings.totalPrice,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                details.totalPrice != null
                    ? '${details.totalPrice}'
                    : (details.feeCurrent ?? ''),
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          if (!isPaid) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => BlocProvider.value(
                      value: context.read<AppointmentDetailsBloc>(),
                      child: ConfirmCashPaymentDialog(details: details),
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: Text(
                  context.strings.confirmCashPayment,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
