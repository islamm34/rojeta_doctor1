import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes/app_router.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../features/auth/data/models/user_type_model.dart';
import '../bloc/services/lab_services_bloc.dart';
import '../bloc/services/lab_services_event.dart';
import '../bloc/services/lab_services_state.dart';
import '../widgets/lab_service_card.dart';
import '../widgets/lab_stat_summary_card.dart';
import 'add_service/add_lab_service_page.dart';

class LabTestsTab extends StatelessWidget {
  final UserType userType;

  const LabTestsTab({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          injector<LabServicesBloc>()..add(FetchLabServicesEvent(userType)),
      child: _LabTestsTabView(userType: userType),
    );
  }
}

class _LabTestsTabView extends StatelessWidget {
  final UserType userType;

  const _LabTestsTabView({required this.userType});

  void _confirmDelete(BuildContext context, String serviceId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.strings.delete),
        content: Text(
          userType == UserType.radiologyCenter
              ? context.strings.deleteScanConfirm
              : context.strings.deleteTestConfirm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.strings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<LabServicesBloc>().add(
                DeleteLabServiceEvent(serviceId, userType),
              );
            },
            child: Text(
              context.strings.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRadiology = userType == UserType.radiologyCenter;
    final appBarTitle = isRadiology
        ? context.strings.radiologyScanTabTitle
        : context.strings.laboratoryTestsTabTitle;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F2D52),
        elevation: 0.5,
      ),
      body: BlocBuilder<LabServicesBloc, LabServicesState>(
        builder: (context, state) {
          if (state.status == LabServicesStatus.loading &&
              state.services.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == LabServicesStatus.failure &&
              state.services.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage ?? context.strings.somethingWentWrong,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LabServicesBloc>().add(
                          FetchLabServicesEvent(userType),
                        );
                      },
                      child: Text(context.strings.retry),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<LabServicesBloc>().add(
                FetchLabServicesEvent(userType),
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isRadiology
                        ? context.strings.manageServiceMenu
                        : context.strings.manageTestMenu,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF7A8FA6),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  if (isRadiology)
                    LabStatSummaryCard(
                      title: context.strings.totalActiveScans,
                      value: state.totalActiveServices.toString(),
                      backgroundColor: const Color(0xFF139EE9),
                      icon: Icons.personal_injury_outlined,
                    )
                  else
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: LabStatSummaryCard(
                              title: context.strings.totalActiveTests,
                              value: state.totalActiveServices.toString(),
                              backgroundColor: const Color(0xFF139EE9),
                              icon: Icons.science_outlined,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: LabStatSummaryCard(
                              title: context.strings.homeVisits,
                              subtitle:
                                  '${state.homeVisitsAvailableCount} ${context.strings.available}',
                              value: state.homeVisitsAvailableCount.toString(),
                              backgroundColor: const Color(0xFF5DF2C1),
                              icon: Icons.house_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 32.h),
                  Text(
                    isRadiology
                        ? context.strings.activeRadiologyScan
                        : context.strings.activeLabTests,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2D52),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  if (state.services.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Center(
                        child: Text(
                          context.strings.noDataAvailable,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF7A8FA6),
                          ),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.services.length,
                      itemBuilder: (context, index) {
                        final service = state.services[index];
                        return LabServiceCard(
                          service: service,
                          onEdit: () async {
                            await context.pushNamed(
                              AppRoutes.addLabService,
                              extra: AddLabServiceArgs(
                                userType: userType,
                                service: service,
                              ),
                            );
                            if (context.mounted) {
                              context.read<LabServicesBloc>().add(
                                FetchLabServicesEvent(userType),
                              );
                            }
                          },
                          onDelete: () {
                            if (service.id != null && service.id!.isNotEmpty) {
                              _confirmDelete(context, service.id!);
                            }
                          },
                        );
                      },
                    ),
                  SizedBox(height: 80.h), // Space for FAB
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.pushNamed(AppRoutes.addLabService, extra: userType);
          if (context.mounted) {
            context.read<LabServicesBloc>().add(
              FetchLabServicesEvent(userType),
            );
          }
        },
        backgroundColor: const Color(0xFF2082FE),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          isRadiology ? context.strings.addScan : context.strings.addTest,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
