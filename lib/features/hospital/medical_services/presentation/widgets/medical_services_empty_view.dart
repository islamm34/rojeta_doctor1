import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../bloc/medical_services_state.dart';
import '../bloc/medical_services_bloc.dart';
import '../bloc/medical_services_event.dart';
import 'setup_progress_card.dart';
import 'hospital_service_toggle.dart';
import '../../data/models/hospital_service_model.dart';

class MedicalServicesEmptyView extends StatelessWidget {
  final MedicalServicesState state;

  const MedicalServicesEmptyView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SetupProgressCard(completedSteps: 0, totalSteps: 3),
        SizedBox(height: 24.h),
        _buildEmptyStateCard(context),
        SizedBox(height: 24.h),
        Text(
          context.strings.enableServicesTitle,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        ...state.services.map(
          (HospitalServiceModel service) => HospitalServiceToggle(
            service: service,
            onChanged: (value) {
              context.read<MedicalServicesBloc>().add(
                ToggleServiceEvent(service.id),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyStateCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.local_hospital_outlined,
            size: 80.w,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16.h),
          Text(
            context.strings.servicesNotSetupTitle,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            context.strings.servicesNotSetupDesc,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              context.pushNamed('/add-specialty');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              context.strings.addYourFirstSpecialtyBtn,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
