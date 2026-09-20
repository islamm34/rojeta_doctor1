import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../bloc/nursing_bloc.dart';
import '../../bloc/nursing_state.dart';
import 'widgets/nursing_services_empty_view.dart';
import 'widgets/nursing_services_populated_view.dart';

class NursingServicesTab extends StatelessWidget {
  const NursingServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          strings.nursingServices,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
      ),
      body: BlocBuilder<NursingBloc, NursingState>(
        builder: (context, state) {
          if (state.status == NursingStatus.loading && state.services.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.services.isEmpty) {
            return const NursingServicesEmptyView();
          }

          return NursingServicesPopulatedView(state: state);
        },
      ),
    );
  }
}

