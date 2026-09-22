import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/routes/app_router.dart';
import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';
import '../../../bloc/nursing_bloc.dart';
import '../../../bloc/nursing_state.dart';
import 'nursing_service_card.dart';

class NursingServicesPopulatedView extends StatelessWidget {
  final NursingState state;

  const NursingServicesPopulatedView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Column(
      children: [
        Container(
          color: const Color(0xFFF8FAFC),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strings.manageServicesSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF64748B),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.nursingAddService,
                      extra: context.read<NursingBloc>(),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text(
                    strings.addService,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.w),
            itemCount: state.services.length,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return NursingServiceCard(service: state.services[index]);
            },
          ),
        ),
      ],
    );
  }
}
