import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../data/models/booking_model.dart';

class BookingStatusChip extends StatelessWidget {
  final BookingStatus? status;

  const BookingStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
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
        bgColor = Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red;
        label = context.strings.filterRejected;
        break;
      case BookingStatus.cancelled:
        bgColor = Colors.grey.withValues(alpha: 0.1);
        textColor = Colors.grey;
        label = context.strings.filterCancelled;
        break;
      case null:
        bgColor = AppColors.pendingIconBg;
        textColor = AppColors.pendingIcon;
        label = context.strings.pendingBookings;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
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
}
