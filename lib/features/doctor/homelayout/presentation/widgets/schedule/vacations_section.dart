import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/schedule_model.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'vacation_item_card.dart';

class VacationsSection extends StatelessWidget {
  final List<VacationModel> vacations;
  final VoidCallback onAddVacation;
  final ValueChanged<String> onRemoveVacation;

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
            Text(
              context.strings.vacationsAndLeaves,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            InkWell(
              onTap: onAddVacation,
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.blue, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      context.strings.addVacation,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ...vacations.map(
          (vac) => VacationItemCard(vacation: vac, onRemove: onRemoveVacation),
        ),
      ],
    );
  }
}
