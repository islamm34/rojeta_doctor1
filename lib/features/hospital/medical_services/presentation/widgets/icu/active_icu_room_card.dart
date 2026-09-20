import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/hospital/medical_services/data/models/icu_room_model.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class ActiveIcuRoomCard extends StatelessWidget {
  final IcuRoomModel room;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ActiveIcuRoomCard({
    super.key,
    required this.room,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusLabel;

    switch (room.status) {
      case 'available':
        statusColor = Colors.teal;
        statusLabel = context.strings.available.toUpperCase();
        break;
      case 'occupied':
        statusColor = Colors.blue.shade800;
        statusLabel = 'NOT AVAILABLE'; // Used in design mockup
        break;
      case 'cleaning':
      default:
        statusColor = Colors.orange;
        statusLabel = context.strings.cleaning.toUpperCase();
        break;
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120.h,
                width: double.infinity,
                color: Colors.grey[300],
                // Typically you would put an image here using Image.network or asset
                child: Center(
                  child: Icon(
                    Icons.local_hospital_outlined,
                    color: Colors.grey[500],
                    size: 40.w,
                  ),
                ),
              ),
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Room ${room.roomNumber.replaceAll('ICU-', '')}',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Bed ID: ${room.bedId} • ${room.floorWing}',
                            style: context.textTheme.labelMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.grey),
                      onPressed: onEdit,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    SizedBox(width: 12.w),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: onDelete,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: room.status == 'available'
                        ? Colors.blueAccent.withValues(alpha: 0.1)
                        : Colors.blue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        room.status == 'available'
                            ? Icons.person_off_outlined
                            : Icons.person,
                        size: 16.w,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        room.assignedPatient ??
                            context.strings.noPatientAssigned,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Colors.blueGrey[800],
                          fontWeight: room.assignedPatient != null
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
