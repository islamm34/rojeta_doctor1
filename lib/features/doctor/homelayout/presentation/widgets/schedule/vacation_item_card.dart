import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/schedule_model.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class VacationItemCard extends StatelessWidget {
  final VacationModel vacation;
  final ValueChanged<String> onRemove;

  const VacationItemCard({
    super.key,
    required this.vacation,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today_outlined, size: 18.sp, color: Colors.blue),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              '${vacation.startDate} to ${vacation.endDate}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onRemove(vacation.id),
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(Icons.delete_outline, color: Colors.red, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
