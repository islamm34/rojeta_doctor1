import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/upcoming_appointment_card.dart';
import '../../../../doctor/homelayout/data/models/doctor_appointment_model.dart';

class HospitalUpcomingAppointmentsSection extends StatelessWidget {
  final List<DoctorAppointmentModel> appointments;
  final VoidCallback? onViewAllTap;

  const HospitalUpcomingAppointmentsSection({
    super.key,
    this.appointments = const [],
    this.onViewAllTap,
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
              context.strings.upcomingAppointments,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 18.sp,
              ),
            ),
            if (appointments.isNotEmpty)
              TextButton(
                onPressed: onViewAllTap,
                child: Text(
                  context.strings.viewAll,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        if (appointments.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 40.sp,
                  color: Colors.grey.shade400,
                ),
                SizedBox(height: 12.h),
                Text(
                  context.strings.noDataAvailable,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: appointments.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return UpcomingAppointmentCard(
                appointment: appointment,
                isActive: index == 0,
                onTap: onViewAllTap ?? () {},
              );
            },
          ),
      ],
    );
  }
}
