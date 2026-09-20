import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/routes/app_router.dart';
import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';
import '../../../bloc/nursing_bloc.dart';

class NursingServicesEmptyView extends StatelessWidget {
  const NursingServicesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            strings.manageServicesSubtitle,
            style: context.textTheme.titleMedium?.copyWith(
              color: const Color(0xFF0F2D52),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
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
          const Spacer(),
        ],
      ),
    );
  }
}
