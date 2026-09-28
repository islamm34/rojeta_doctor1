import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import '../../bloc/nursing_bloc.dart';
import '../../bloc/nursing_event.dart';
import '../../bloc/nursing_state.dart';
import 'widgets/nursing_add_coverage_area_sheet.dart';
import 'widgets/nursing_coverage_area_card.dart';
import 'widgets/nursing_coverage_empty_state.dart';
import 'widgets/nursing_coverage_header_card.dart';

class NursingCoverageAreasPage extends StatelessWidget {
  const NursingCoverageAreasPage({super.key});

  void _showAddAreaSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => NursingAddCoverageAreaSheet(
        onAdd: (area) {
          context.read<NursingBloc>().add(AddNursingCoverageAreaEvent(area));
        },
      ),
    );
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
          strings.coverageAreas,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2D52)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Color(0xFF0284C7)),
            onPressed: () => _showAddAreaSheet(context),
          ),
        ],
      ),
      body: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          if (state.status == NursingStatus.loading && state.coverageAreas.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final areas = state.coverageAreas;
          final activeCount = areas.where((a) => a.isActive).length;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<NursingBloc>().add(LoadNursingCoverageAreasEvent());
            },
            child: areas.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16.w),
                    children: [
                      NursingCoverageHeaderCard(
                        totalAreas: 0,
                        activeAreas: 0,
                      ),
                      SizedBox(height: 40.h),
                      NursingCoverageEmptyState(
                        onAddPressed: () => _showAddAreaSheet(context),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16.w),
                    itemCount: areas.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: NursingCoverageHeaderCard(
                            totalAreas: areas.length,
                            activeAreas: activeCount,
                          ),
                        );
                      }

                      final area = areas[index - 1];
                      return NursingCoverageAreaCard(
                        area: area,
                        onToggleActive: (isActive) {
                          context.read<NursingBloc>().add(
                            ToggleNursingCoverageAreaEvent(
                              areaId: area.id,
                              isActive: isActive,
                            ),
                          );
                        },
                        onDelete: () {
                          context.read<NursingBloc>().add(
                            DeleteNursingCoverageAreaEvent(area.id),
                          );
                        },
                      );
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAreaSheet(context),
        backgroundColor: const Color(0xFF2563EB),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          strings.addArea,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
