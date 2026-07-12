import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/patient_model.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class PatientHeaderCard extends StatelessWidget {
  final PatientModel patient;

  const PatientHeaderCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1877F2), Color(0xFF00A2E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1877F2).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: Icon(Icons.person, color: Colors.white, size: 28.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.name,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 14.r, color: Colors.white70),
                        SizedBox(width: 4.w),
                        Text(
                          patient.phone,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoBox(
                  context,
                  '${context.strings.age} • ${context.strings.gender}',
                  '${patient.age} ${context.strings.years} • ${patient.gender == 'Male' ? context.strings.male : context.strings.female}',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoBox(
                  context,
                  context.strings.totalPatients,
                  '${patient.visitsCount} ${context.strings.visits}',
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInfoBox(
                  context,
                  context.strings.lastVisit,
                  DateFormat('yyyy-MM-dd').format(patient.lastVisitDate),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(BuildContext context, String title, String value) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.labelMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: context.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
