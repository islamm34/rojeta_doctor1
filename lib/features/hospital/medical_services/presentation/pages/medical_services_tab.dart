import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../bloc/medical_services_bloc.dart';
import '../bloc/medical_services_event.dart';
import '../bloc/medical_services_state.dart';
import '../widgets/medical_services_app_bar.dart';
import '../widgets/medical_services_empty_view.dart';
import '../widgets/medical_services_populated_view.dart';
import '../widgets/medical_services_stats_row.dart';

class MedicalServicesTab extends StatefulWidget {
  const MedicalServicesTab({super.key});

  @override
  State<MedicalServicesTab> createState() => _MedicalServicesTabState();
}

class _MedicalServicesTabState extends State<MedicalServicesTab> {
  @override
  void initState() {
    super.initState();
    context.read<MedicalServicesBloc>().add(FetchMedicalServicesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalServicesBloc, MedicalServicesState>(
      builder: (context, state) {
        if (state.status == MedicalServicesStatus.loading ||
            state.status == MedicalServicesStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.homeBg,
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<MedicalServicesBloc>().add(
                FetchMedicalServicesEvent(),
              );
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const MedicalServicesAppBar(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.strings.manageSpecialtiesSubtitle,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        MedicalServicesStatsRow(state: state),
                        SizedBox(height: 24.h),
                        if (!state.isSetupComplete)
                          MedicalServicesEmptyView(state: state)
                        else
                          MedicalServicesPopulatedView(state: state),
                        SizedBox(height: 100.h), // Padding for bottom nav
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: state.isSetupComplete
              ? FloatingActionButton.extended(
                  onPressed: () {
                    context.pushNamed('/add-specialty');
                  },
                  backgroundColor: AppColors.primary,
                  label: Text(
                    context.strings.addSpecialtyBtn,
                    style: const TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                )
              : null,
        );
      },
    );
  }
}
