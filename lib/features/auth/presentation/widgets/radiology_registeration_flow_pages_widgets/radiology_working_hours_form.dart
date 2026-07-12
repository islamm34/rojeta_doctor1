import '../../../../../core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/screen_util_like.dart';

class RadiologyWorkingHoursForm extends StatefulWidget {
  const RadiologyWorkingHoursForm({super.key});

  @override
  State<RadiologyWorkingHoursForm> createState() =>
      _RadiologyWorkingHoursFormState();
}

class _RadiologyWorkingHoursFormState extends State<RadiologyWorkingHoursForm> {
  bool _isOpen24_7 = false;

  final List<Map<String, dynamic>> _days = [
    {'day': 'Sunday', 'from': '09:00 AM', 'to': '05:00 PM', 'closed': false},
    {'day': 'Monday', 'from': '09:00 AM', 'to': '05:00 PM', 'closed': false},
    {'day': 'Tuesday', 'from': '09:00 AM', 'to': '05:00 PM', 'closed': true},
    {'day': 'Wednesday', 'from': '09:00 AM', 'to': '05:00 PM', 'closed': true},
    {'day': 'Thursday', 'from': '09:00 AM', 'to': '05:00 PM', 'closed': true},
    {'day': 'Friday', 'from': '09:00 AM', 'to': '05:00 PM', 'closed': true},
    {'day': 'Saturday', 'from': '09:00 AM', 'to': '05:00 PM', 'closed': true},
  ];

  String _getLocalizedDayName(BuildContext context, String englishName) {
    switch (englishName.toLowerCase()) {
      case 'sunday':
        return context.strings.sunday;
      case 'monday':
        return context.strings.monday;
      case 'tuesday':
        return context.strings.tuesday;
      case 'wednesday':
        return context.strings.wednesday;
      case 'thursday':
        return context.strings.thursday;
      case 'friday':
        return context.strings.friday;
      case 'saturday':
        return context.strings.saturday;
      default:
        return englishName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.strings.workingHoursTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Text(
                    context.strings.open24_7,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Switch(
                    value: _isOpen24_7,
                    onChanged: (val) {
                      setState(() {
                        _isOpen24_7 = val;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (!_isOpen24_7) ...[
            ..._days.map((dayData) {
              final isClosed = dayData['closed'] as bool;
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _getLocalizedDayName(context, dayData['day'] as String),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F1E36),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (isClosed) ...[
                      Expanded(
                        child: Center(
                          child: Text(
                            context.strings.closed,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF2980B9),
                          side: const BorderSide(color: Color(0xFF3498DB)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            dayData['closed'] = false;
                          });
                        },
                        child: Text(
                          'Activate', // ponytail: generic action name, not localized as it represents active activation mechanism.
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: _buildTimeField(
                          label: 'From',
                          value: dayData['from'] as String,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // "To" Input Box
                      Expanded(
                        child: _buildTimeField(
                          label: 'To',
                          value: dayData['to'] as String,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Delete Icon Button
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Color(0xFFC0392B),
                          size: 24,
                        ),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            dayData['closed'] = true;
                          });
                        },
                      ),
                    ],
                  ],
                ),
              );
            }),
            SizedBox(height: 16.h),
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline),
                label: Text(context.strings.addAnotherWorkingDay),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeField({required String label, required String value}) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF3498DB)),
        ),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: const Color(0xFF0F1E36),
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
