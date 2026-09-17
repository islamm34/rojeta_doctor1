import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/di/injector.dart';
import '../../../../../../features/auth/data/models/user_type_model.dart';
import '../../bloc/manage_branch/manage_branch_bloc.dart';
import '../../bloc/manage_branch/manage_branch_event.dart';
import '../../bloc/manage_branch/manage_branch_state.dart';
import 'widgets/branch_item_card.dart';
import 'widgets/branch_stats_card.dart';

class ManageBranchPage extends StatelessWidget {
  final UserType userType;

  const ManageBranchPage({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          injector<ManageBranchBloc>()
            ..add(LoadBranchesEvent(userType: userType)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Manage Branch',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D52),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: false,
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        body: BlocBuilder<ManageBranchBloc, ManageBranchState>(
          builder: (context, state) {
            if (state.status == ManageBranchStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ManageBranchStatus.failure) {
              return Center(
                child: Text(state.errorMessage ?? 'An error occurred'),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userType == UserType.radiologyCenter
                        ? 'Oversee Radiology locations, operational hours, and service availability.'
                        : 'Oversee laboratory locations, operational hours, and service availability.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF7A8FA6),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  BranchStatsCard(
                    totalBranches: state.totalBranches,
                    activeCollections: state.activeCollections,
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final result = await context.pushNamed(
                          AppRoutes.addBranch,
                          extra: userType,
                        );
                        if (result == true && context.mounted) {
                          context.read<ManageBranchBloc>().add(
                            LoadBranchesEvent(userType: userType),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2CC069),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Add Branch',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.branches.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final branch = state.branches[index];
                      return BranchItemCard(
                        branch: branch,
                        onEdit: () {},
                        onDelete: () {
                          context.read<ManageBranchBloc>().add(
                            DeleteBranchEvent(branchId: branch.id ?? ''),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
