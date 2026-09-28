import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/models/icu_room_model.dart';
import '../widgets/icu/active_icu_room_card.dart';
import '../widgets/icu/add_icu_room_form.dart';

class IcuManagementPage extends StatelessWidget {
  const IcuManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<IcuRoomModel> mockRooms = [
      IcuRoomModel(
        id: '1',
        roomNumber: 'ICU-401',
        bedId: 'B-01',
        floorWing: 'North Wing',
        equipmentList: ['Ventilator', 'Vitals Monitor'],
        status: 'available',
      ),
      IcuRoomModel(
        id: '2',
        roomNumber: 'ICU-405',
        bedId: 'B-05',
        floorWing: 'South Wing',
        equipmentList: ['Ventilator', 'Infusion Pump'],
        status: 'occupied',
        assignedPatient: 'John D. - ID: 29384',
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
          context.strings.icuManagementTitle,
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(12.r),
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
                                  'ICU Service',
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
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
                                    color: Colors.tealAccent.withValues(
                                      alpha: 0.3,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Text(
                                    'Active',
                                    style: context.textTheme.labelSmall
                                        ?.copyWith(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              context.strings.icuServiceDesc,
                              style: context.textTheme.labelMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF00B14F,
                        ), // Green from mockup
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      icon: const Icon(Icons.add, size: 20),
                      label: Text(
                        context.strings.addRoomBedBtn.replaceAll('+ ', ''),
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.strings.totalUnits,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '24',
                              style: context.textTheme.titleLarge?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40.h,
                        color: Colors.grey[300],
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.strings.inUse,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '18',
                              style: context.textTheme.titleLarge?.copyWith(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            const AddIcuRoomForm(),
            SizedBox(height: 32.h),
            Text(
              context.strings.activeIcuRoomsTitle,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                _buildStatusDot(Colors.teal, context.strings.available),
                SizedBox(width: 12.w),
                _buildStatusDot(Colors.blue.shade800, context.strings.occupied),
                SizedBox(width: 12.w),
                _buildStatusDot(Colors.orange, context.strings.cleaning),
              ],
            ),
            SizedBox(height: 16.h),
            ...mockRooms.map((room) => ActiveIcuRoomCard(room: room)),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[800]),
        ),
      ],
    );
  }
}
