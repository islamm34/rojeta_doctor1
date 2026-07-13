import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/lab&radiology/homelayout/data/models/lab_service_model.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

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
                  service.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F2D52),
                      ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Theme.of(context).primaryColor, size: 20.w),
                    onPressed: onEdit,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(width: 12.w),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red, size: 20.w),
                    onPressed: onDelete,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            '${service.price.toStringAsFixed(0)} EGP',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              if (service.isHomeCollectionAvailable)
                _buildChip(
                  context,
                  icon: Icons.home_outlined,
                  label: context.strings.homeCollection,
                ),
              _buildChip(
                context,
                icon: Icons.access_time,
                label: service.turnaroundTime,
              ),
              _buildChip(
                context,
                icon: Icons.medical_services_outlined,
                label: service.category,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, {required IconData icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.w, color: const Color(0xFF7A8FA6)),
          SizedBox(width: 6.w),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF0F2D52),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
