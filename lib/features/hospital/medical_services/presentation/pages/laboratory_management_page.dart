import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/models/lab_test_model.dart';
import '../widgets/laboratory/active_lab_test_card.dart';
import '../widgets/laboratory/add_test_form.dart';

class LaboratoryManagementPage extends StatelessWidget {
  const LaboratoryManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for the active lab tests based on the design
    final List<LabTestModel> mockTests = [
      LabTestModel(
        id: '1',
        name: 'Complete Blood Count (CBC)',
        price: 150,
        category: 'Hematology',
        homeCollectionAvailable: true,
        estimatedResultTime: '24 hours',
      ),
      LabTestModel(
        id: '2',
        name: 'Lipid Profile',
        price: 450,
        category: '',
        homeCollectionAvailable: true,
        estimatedResultTime: '48 hours',
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
          context.strings.laboratoryManagementTitle,
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
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.science,
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
                              'Laboratory Service',
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
                                color: Colors.tealAccent.withValues(alpha: 0.3),
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
                          context.strings.laboratoryServiceDesc,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.strings.addNewTestTitle,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.info_outline, color: Colors.grey[500]),
              ],
            ),
            SizedBox(height: 16.h),
            const AddTestForm(),
            SizedBox(height: 32.h),
            Text(
              context.strings.activeLabTestsTitle,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            ...mockTests.map((test) => ActiveLabTestCard(test: test)),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
