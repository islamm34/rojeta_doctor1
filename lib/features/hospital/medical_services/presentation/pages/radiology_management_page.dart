import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../widgets/radiology/add_radiology_service_form.dart';
import '../widgets/radiology/active_radiology_service_card.dart';
import '../../data/models/radiology_service_model.dart';

class RadiologyManagementPage extends StatelessWidget {
  const RadiologyManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for the active radiology services based on the design
    final List<RadiologyServiceModel> mockServices = [
      RadiologyServiceModel(
        id: '1',
        name: 'Chest X-Ray',
        price: 250,
        category: 'Diagnostic',
        contrastAgentRequired: false,
        estimatedDuration: '15 MINS',
      ),
      RadiologyServiceModel(
        id: '2',
        name: 'Brain MRI',
        price: 1800,
        category: '',
        contrastAgentRequired: true,
        estimatedDuration: '45 MINS',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: AppBar(
        backgroundColor: AppColors.homeBg,
        surfaceTintColor: AppColors.homeBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.strings.radiologyManagementTitle,
          style: context.textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.monitor_heart_outlined,
                      color: AppColors.primary,
                      size: 30.w,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Radiology Service',
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.tealAccent.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                'Active',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          context.strings.radiologyServiceDesc,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              context.strings.addNewServiceTitle,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            const AddRadiologyServiceForm(),
            SizedBox(height: 32.h),
            Text(
              '${context.strings.activeServicesTitle} (${mockServices.length})',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            ...mockServices.map(
              (service) => ActiveRadiologyServiceCard(service: service),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
