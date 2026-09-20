import 'package:flutter/material.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class NursingGenderRadio extends StatelessWidget {
  final String title;
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const NursingGenderRadio({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedValue == title;

    return InkWell(
      onTap: () => onChanged(title),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFFCBD5E1),
                width: 1.5,
              ),
            ),
            padding: EdgeInsets.all(3.w),
            child: isSelected
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF3B82F6),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF334155),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
