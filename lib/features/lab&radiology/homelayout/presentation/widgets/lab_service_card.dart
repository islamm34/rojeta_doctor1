import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/lab&radiology/homelayout/data/models/lab_service_model.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import 'lab_service_chip.dart';

class LabServiceCard extends StatelessWidget {
  final LabServiceModel service;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const LabServiceCard({
    super.key,
    required this.service,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final name = service.name ?? '';
    final price = service.price;
    final turnaroundTime = service.turnaroundTime ?? '';
    final category = service.category ?? '';
    final requiresFasting = service.requiresFasting ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2D52),
                  ),
                ),
              ),
              Row(
                children: [
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.edit,
                  //     color: Theme.of(context).primaryColor,
                  //     size: 20.w,
                  //   ),
                  //   onPressed: onEdit,
                  //   constraints: const BoxConstraints(),
                  //   padding: EdgeInsets.zero,
                  // ),
                  // SizedBox(width: 12.w),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: onDelete,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ],
          ),
          if (price != null) ...[
            SizedBox(height: 4.h),
            Text(
              '${price.toStringAsFixed(0)} EGP',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              if (turnaroundTime.isNotEmpty) ...[
                LabServiceChip(icon: Icons.access_time, label: turnaroundTime),
                SizedBox(width: 8.w),
              ],
              if (requiresFasting) ...[
                LabServiceChip(
                  icon: Icons.no_food_outlined,
                  label: context.strings.fastingRequired,
                ),
                SizedBox(width: 8.w),
              ],
              if (category.isNotEmpty)
                LabServiceChip(
                  icon: Icons.medical_services_outlined,
                  label: category,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
