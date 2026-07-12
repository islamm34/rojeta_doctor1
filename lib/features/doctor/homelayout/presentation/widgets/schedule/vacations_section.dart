import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/schedule_model.dart';

class VacationsSection extends StatelessWidget {
  final List<VacationModel> vacations;
  final VoidCallback onAddVacation;
  final Function(String) onRemoveVacation;

  const VacationsSection({
    super.key,
    required this.vacations,
    required this.onAddVacation,
    required this.onRemoveVacation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                context.strings.vacationsAndUnavailable,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onAddVacation,
              icon: Icon(Icons.add, size: 16.sp, color: Colors.white),
              label: Text(
                context.strings.add,
                style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA533FF), // Purple matching the mock
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                elevation: 0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ...vacations.map((vac) => _buildVacationCard(vac)),
      ],
    );
  }

  Widget _buildVacationCard(VacationModel vacation) {
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
            onTap: () => onRemoveVacation(vacation.id),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 16.sp, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
