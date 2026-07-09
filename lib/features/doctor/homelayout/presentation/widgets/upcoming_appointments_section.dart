import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/mocks/doctor_mock_data.dart';
import 'upcoming_appointment_card.dart';

class UpcomingAppointmentsSection extends StatelessWidget {
  final VoidCallback? onViewAllTap;

  const UpcomingAppointmentsSection({
    super.key,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    // Take up to 3 upcoming appointments for the preview
    final upcomingAppointments = DoctorMockData.appointments.take(3).toList();

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
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: upcomingAppointments.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final appointment = upcomingAppointments[index];
            return UpcomingAppointmentCard(
              appointment: appointment,
              isActive: index == 0,
              onTap: () {
                // Navigate to appointment details if needed
              },
            );
          },
        ),
      ],
    );
  }
}
