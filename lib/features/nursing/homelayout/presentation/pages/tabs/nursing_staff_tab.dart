import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_staff_model.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/presentation/bloc/nursing_event.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../bloc/nursing_bloc.dart';
import '../../bloc/nursing_state.dart';
import 'widgets/nursing_staff_card.dart';
import 'widgets/nursing_staff_stat_card.dart';

class NursingStaffTab extends StatefulWidget {
  const NursingStaffTab({super.key});

  @override
  State<NursingStaffTab> createState() => _NursingStaffTabState();
}

class _NursingStaffTabState extends State<NursingStaffTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          strings.staffManagement,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
      ),
      body: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          if (state.status == NursingStatus.loading && state.staff.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final stats = state.staffStats;
          List<NursingStaffModel> filteredStaff = state.staff;
          if (_tabController.index == 1) {
            filteredStaff = state.staff
                .where((s) => (s.gender ?? '').toUpperCase() == 'MALE')
                .toList();
          } else if (_tabController.index == 2) {
            filteredStaff = state.staff
                .where((s) => (s.gender ?? '').toUpperCase() == 'FEMALE')
                .toList();
          }

          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  context.read<NursingBloc>().add(LoadNursingStaffEvent());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 80.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              strings.manageStaffSubtitle,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF475569),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            // Stat Cards Grid
                            Row(
                              children: [
                                Expanded(
                                  child: NursingStaffStatCard(
                                    title: strings.totalStaff,
                                    value:
                                        (stats?.totalStaff ??
                                                state.staff.length)
                                            .toString(),
                                    icon: Icons.people_outline,
                                    color: const Color(0xFF0EA5E9),
                                    textColor: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: NursingStaffStatCard(
                                    title: strings.available,
                                    value: (stats?.available ?? 0).toString(),
                                    icon: Icons.check_circle_outline,
                                    color: const Color(0xFF6EE7B7),
                                    textColor: const Color(0xFF064E3B),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Expanded(
                                  child: NursingStaffStatCard(
                                    title: strings.onDuty,
                                    value: (stats?.onDuty ?? 0).toString(),
                                    icon: Icons.more_horiz,
                                    color: const Color(0xFFE2E8F0),
                                    textColor: const Color(0xFF0F172A),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: NursingStaffStatCard(
                                    title: strings.onLeave,
                                    value: (stats?.onLeave ?? 0).toString(),
                                    icon: Icons.calendar_today_outlined,
                                    color: const Color(0xFFE0E7FF),
                                    textColor: const Color(0xFF1E1B4B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Tabs
                      Container(
                        color: Colors.white,
                        child: TabBar(
                          controller: _tabController,
                          labelColor: const Color(0xFF3B82F6),
                          unselectedLabelColor: const Color(0xFF64748B),
                          indicatorColor: const Color(0xFF3B82F6),
                          tabs: [
                            Tab(text: strings.all),
                            Tab(text: strings.male),
                            Tab(text: strings.female),
                          ],
                        ),
                      ),
                      // List
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: filteredStaff.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 40.h),
                                  child: Text(
                                    strings.noStaffFound,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          color: const Color(0xFF64748B),
                                        ),
                                  ),
                                ),
                              )
                            : Column(
                                children: filteredStaff.map((staff) {
                                  return NursingStaffCard(
                                    staff: staff,
                                    onEdit: () {},
                                    onDelete: () {},
                                  );
                                }).toList(),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              // Floating Button
              Positioned(
                bottom: 16.h,
                right: 16.w,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.nursingAddNurse,
                      extra: context.read<NursingBloc>(),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text(
                    strings.addNurse,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
