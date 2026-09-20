import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';
import 'package:rojeta_doctor/shared/widgets/upcoming_appointment_card.dart';
import '../bloc/homelayout_bloc.dart';

class UpcomingAppointmentsSection extends StatelessWidget {
  final VoidCallback? onViewAllTap;

  const UpcomingAppointmentsSection({
    super.key,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final upcomingAppointments = context
        .watch<HomelayoutBloc>()
        .state
        .upcomingAppointments
        .take(3)
        .toList();

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
        if (upcomingAppointments.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Center(
              child: Text(
                context.strings.noDataAvailable,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14.sp,
                ),
              ),
            ),
          )
        else
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
                  context.pushNamed(
                    AppRoutes.appointmentDetails,
                    extra: appointment.id,
                  );
                },
              );
            },
          ),
      ],
    );
  }
}
