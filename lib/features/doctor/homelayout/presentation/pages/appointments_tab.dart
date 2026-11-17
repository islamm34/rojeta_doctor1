import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/di/injector.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../chat/data/repositories/doctor_chat_repository.dart';
import '../bloc/appointments/doctor_appointments_bloc.dart';
import '../bloc/appointments/doctor_appointments_event.dart';
import '../bloc/appointments/doctor_appointments_state.dart';
import '../widgets/appointment/appointments_tab_card.dart';

class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<DoctorAppointmentsBloc>();
      return const AppointmentsTabView();
    } catch (_) {
      return BlocProvider(
        create: (_) =>
            injector<DoctorAppointmentsBloc>()
              ..add(const FetchAppointmentsEvent()),
        child: const AppointmentsTabView(),
      );
    }
  }
}

class AppointmentsTabView extends StatefulWidget {
  const AppointmentsTabView({super.key});

  @override
  State<AppointmentsTabView> createState() => _AppointmentsTabViewState();
}

class _AppointmentsTabViewState extends State<AppointmentsTabView> {
  final List<String> _filters = [
    'All',
    'Pending',
    'Confirmed',
    'Completed',
    'Cancelled',
  ];

  String _getFilterLabel(BuildContext context, String filter) {
    switch (filter.toLowerCase()) {
      case 'all':
        return context.strings.filterAll;
      case 'pending':
        return context.strings.filterPending;
      case 'confirmed':
        return context.strings.filterConfirmed;
      case 'completed':
        return context.strings.filterCompleted;
      case 'cancelled':
        return context.strings.filterCancelled;
      default:
        return filter;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          context.strings.appointments,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<DoctorAppointmentsBloc, DoctorAppointmentsState>(
        builder: (context, state) {
          final selectedFilter = state.selectedFilter;
          final filteredAppointments = state.filteredAppointments;

          return Column(
            children: [
              // Filter Chips Row
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filters.map((filter) {
                      final isSelected =
                          selectedFilter.toLowerCase() == filter.toLowerCase();
                      return Padding(
                        padding: EdgeInsetsDirectional.only(end: 8.w),
                        child: ChoiceChip(
                          label: Text(
                            _getFilterLabel(context, filter),
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: Colors.blue,
                          backgroundColor: Colors.white,
                          showCheckmark: false,
                          side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              context.read<DoctorAppointmentsBloc>().add(
                                FilterAppointmentsByStatusEvent(filter),
                              );
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Appointments List / States
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (state.status == DoctorAppointmentsStatus.loading &&
                        state.appointments.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == DoctorAppointmentsStatus.failure &&
                        state.appointments.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.errorMessage ??
                                  context.strings.somethingWentWrong,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            ElevatedButton(
                              onPressed: () {
                                context.read<DoctorAppointmentsBloc>().add(
                                  const FetchAppointmentsEvent(),
                                );
                              },
                              child: Text(context.strings.retry),
                            ),
                          ],
                        ),
                      );
                    }

                    if (filteredAppointments.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<DoctorAppointmentsBloc>().add(
                            const FetchAppointmentsEvent(),
                          );
                        },
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(height: 120.h),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 64.sp,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    context.strings.noDataAvailable,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<DoctorAppointmentsBloc>().add(
                          const FetchAppointmentsEvent(),
                        );
                      },
                      child: ListView.separated(
                        padding: EdgeInsets.all(16.w),
                        itemCount: filteredAppointments.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final appointment = filteredAppointments[index];
                          return AppointmentsTabCard(
                            appointment: appointment,
                            onAccept: () async {
                              context.read<DoctorAppointmentsBloc>().add(
                                UpdateAppointmentStatusEvent(
                                  appointmentId: appointment.id,
                                  status: 'Confirmed',
                                ),
                              );
                              try {
                                final targetPatientId =
                                    (appointment.patientId?.isNotEmpty ?? false)
                                        ? appointment.patientId!
                                        : appointment.id;
                                final conv = await injector<DoctorChatRepository>()
                                    .getOrCreateConversation(
                                      patientId: targetPatientId,
                                      patientName: appointment.patientName,
                                    );
                                await injector<DoctorChatRepository>().sendMessage(
                                  conversationId: conv.id,
                                  content:
                                      'تم قبول موعدك بنجاح ✅ - الموعد: ${appointment.appointmentDate} الساعة ${appointment.appointmentTime}',
                                );
                              } catch (_) {}
                            },
                            onReject: () {
                              context.read<DoctorAppointmentsBloc>().add(
                                UpdateAppointmentStatusEvent(
                                  appointmentId: appointment.id,
                                  status: 'Cancelled',
                                ),
                              );
                            },
                            onViewDetails: () {
                              context.pushNamed(
                                AppRoutes.appointmentDetails,
                                extra: appointment.id,
                              );
                            },
                            onStartConsultation: () async {
                              try {
                                final targetPatientId =
                                    (appointment.patientId?.isNotEmpty ?? false)
                                        ? appointment.patientId!
                                        : appointment.id;
                                final conv = await injector<DoctorChatRepository>()
                                    .getOrCreateConversation(
                                      patientId: targetPatientId,
                                      patientName: appointment.patientName,
                                    );
                                await injector<DoctorChatRepository>().sendMessage(
                                  conversationId: conv.id,
                                  content:
                                      '🩺 بدأ الطبيب الاستشارة الطبية معك الآن. يمكنك كتابة استفساراتك وسيقوم الطبيب بمتابعتك مباشرة.',
                                );
                              } catch (_) {}

                              final result = await context.pushNamed(
                                AppRoutes.medicalConsultation,
                                extra: appointment,
                              );
                              if (result == true && context.mounted) {
                                context.read<DoctorAppointmentsBloc>().add(
                                  const FetchAppointmentsEvent(),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
