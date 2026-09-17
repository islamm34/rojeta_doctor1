import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/extensions/time_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_event.dart';

class NursingWorkingHoursPage extends StatefulWidget {
  const NursingWorkingHoursPage({super.key});

  @override
  State<NursingWorkingHoursPage> createState() =>
      _NursingWorkingHoursPageState();
}

class _NursingWorkingHoursPageState extends State<NursingWorkingHoursPage> {
  late NursingWorkingHoursModel _workingHours;

  @override
  void initState() {
    super.initState();
    final state = context.read<NursingBloc>().state;
    _workingHours =
        state.workingHours ??
        const NursingWorkingHoursModel(days: []); // Default empty if null
  }

  void _saveChanges() {
    context.read<NursingBloc>().add(
      UpdateNursingWorkingHoursEvent(_workingHours),
    );
    context.pop();
  }

  void _updateDay(int index, DailyWorkingHoursModel day) {
    final newDays = List<DailyWorkingHoursModel>.from(_workingHours.days);
    newDays[index] = day;
    setState(() {
      _workingHours = _workingHours.copyWith(days: newDays);
    });
  }

  Future<void> _selectTime(int index, bool isOpenTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final day = _workingHours.days[index];
      final formattedTime = picked.formatTimeOfDay();
      if (isOpenTime) {
        _updateDay(index, day.copyWith(openTime: formattedTime));
      } else {
        _updateDay(index, day.copyWith(closeTime: formattedTime));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Working Hours',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set your office working hours. Patients will only be able to book appointments during these times.',
              style: context.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF475569),
              ),
            ),
            SizedBox(height: 24.h),
            if (_workingHours.days.isEmpty)
              const Center(child: Text('No working hours data available.'))
            else
              ...List.generate(_workingHours.days.length, (index) {
                final day = _workingHours.days[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              day.day,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Switch(
                              value: day.isOpen,
                              onChanged: (val) {
                                _updateDay(index, day.copyWith(isOpen: val));
                              },
                              activeThumbColor: Colors.white,
                              activeTrackColor: const Color(0xFF2563EB),
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: const Color(0xFFE2E8F0),
                            ),
                          ],
                        ),
                        if (day.isOpen) ...[
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTimePicker(
                                  label: 'Opening Time',
                                  time: day.openTime,
                                  onTap: () => _selectTime(index, true),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: _buildTimePicker(
                                  label: 'Closing Time',
                                  time: day.closeTime,
                                  onTap: () => _selectTime(index, false),
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(
                                Icons.bedtime_outlined,
                                color: const Color(0xFF94A3B8),
                                size: 16.w,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Closed',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            SizedBox(height: 100.h), // space for bottom buttons
          ],
        ),
      ),
      bottomSheet: Container(
        color: const Color(0xFFF8FAFC),
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      side: const BorderSide(color: Color(0xFF94A3B8)),
                    ),
                    child: Text(
                      'DISCARD',
                      style: TextStyle(
                        color: const Color(0xFF0F2D52),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _saveChanges,
                    icon: Icon(
                      Icons.save_outlined,
                      color: Colors.white,
                      size: 16.w,
                    ),
                    label: Text(
                      'SAVE CHANGES',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker({
    required String label,
    required String time,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: const Color(0xFF475569),
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 6.h),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFCBD5E1)),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time, style: const TextStyle(color: Color(0xFF0F172A))),
                Icon(
                  Icons.access_time,
                  color: const Color(0xFF64748B),
                  size: 18.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
