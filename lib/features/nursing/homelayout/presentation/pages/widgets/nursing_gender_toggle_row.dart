import 'package:flutter/material.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class NursingGenderToggleRow extends StatelessWidget {
  final String selectedGender;
  final String maleLabel;
  final String femaleLabel;
  final ValueChanged<String> onChanged;

  const NursingGenderToggleRow({
    super.key,
    required this.selectedGender,
    required this.maleLabel,
    required this.femaleLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isMale = selectedGender == 'Male';
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged('Male'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: isMale ? Colors.white : const Color(0xFFDBEAFE),
                border: isMale ? Border.all(color: const Color(0xFF3B82F6)) : null,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                maleLabel,
                style: TextStyle(
                  color: isMale ? const Color(0xFF1E3A8A) : const Color(0xFF64748B),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged('Female'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: !isMale ? Colors.white : const Color(0xFFDBEAFE),
                border: !isMale ? Border.all(color: const Color(0xFF3B82F6)) : null,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                femaleLabel,
                style: TextStyle(
                  color: !isMale ? const Color(0xFF1E3A8A) : const Color(0xFF64748B),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
