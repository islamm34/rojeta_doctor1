import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../bloc/appointment_details/appointment_details_bloc.dart';
import '../bloc/appointment_details/appointment_details_event.dart';
import '../bloc/appointment_details/appointment_details_state.dart';
import '../widgets/appointment_details/appointment_details_consultation_card.dart';
import '../widgets/appointment_details/appointment_details_error_view.dart';
import '../widgets/appointment_details/appointment_details_header_card.dart';
import '../widgets/appointment_details/appointment_details_medical_notes_card.dart';
import '../widgets/appointment_details/appointment_details_notes_card.dart';
import '../widgets/appointment_details/appointment_details_payment_card.dart';
import '../widgets/appointment_details/appointment_details_schedule_card.dart';

class DoctorAppointmentDetailsPage extends StatelessWidget {
  final String appointmentId;

  const DoctorAppointmentDetailsPage({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.strings.appointmentDetails,
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: BlocBuilder<AppointmentDetailsBloc, AppointmentDetailsState>(
        builder: (context, state) {
          if (state.status == AppointmentDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == AppointmentDetailsStatus.failure) {
            return AppointmentDetailsErrorView(
              errorMessage:
                  state.errorMessage ?? context.strings.somethingWentWrong,
              onRetry: () {
                context.read<AppointmentDetailsBloc>().add(
                  FetchAppointmentDetailsEvent(appointmentId),
                );
              },
            );
          }

          final details = state.appointmentDetails;
          if (details == null) {
            return const SizedBox.shrink();
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<AppointmentDetailsBloc>().add(
                FetchAppointmentDetailsEvent(appointmentId),
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppointmentDetailsHeaderCard(details: details),
                  SizedBox(height: 16.h),
                  AppointmentDetailsScheduleCard(details: details),
                  SizedBox(height: 16.h),
                  AppointmentDetailsPaymentCard(details: details),
                  if (details.notes != null && details.notes!.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    AppointmentDetailsNotesCard(
                      notes: details.notes!,
                      attachments: details.attachments,
                    ),
                  ],
                  if (details.consultation != null) ...[
                    SizedBox(height: 16.h),
                    AppointmentDetailsConsultationCard(
                      consultation: details.consultation!,
                    ),
                  ],
                  if (details.medicalNotesImages.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    AppointmentDetailsMedicalNotesCard(
                      images: details.medicalNotesImages,
                    ),
                  ],
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
