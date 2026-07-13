import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../bloc/medical_services_bloc.dart';
import '../bloc/medical_services_event.dart';
import '../bloc/medical_services_state.dart';
import '../widgets/medical_services_empty_view.dart';
import '../widgets/medical_services_populated_view.dart';

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
          body: CustomScrollView(
            slivers: [
              _buildAppBar(context),
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
                      _buildStatsRow(context, state),
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

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: AppColors.homeBg,
      backgroundColor: AppColors.homeBg,
      elevation: 0,
      pinned: true,
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back, color: Colors.black),
      //   onPressed: () => context.pop(),
      // ),
      title: Text(
        context.strings.medicalServicesTitle,
        style: context.textTheme.titleLarge?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildStatsRow(BuildContext context, MedicalServicesState state) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: context.strings.activeSpecialties,
            value: state.activeSpecialtiesCount.toString(),
            color: const Color(0xFFFFF9E5),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _StatCard(
            title: context.strings.totalStaff,
            value: state.totalStaffCount.toString(),
            color: const Color(0xFFE5F5E9),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: context.textTheme.headlineMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
