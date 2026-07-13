import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import '../../../../data/models/branch_model.dart';

class BranchItemCard extends StatelessWidget {
  final BranchModel branch;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BranchItemCard({
    super.key,
    required this.branch,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        branch.name,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F2D52),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Color(0xFF7A8FA6), size: 20),
                      onPressed: onEdit,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(width: 12.w),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Color(0xFF7A8FA6), size: 20),
                      onPressed: onDelete,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
                if (branch.isHomeCollectionAvailable) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF45F5D0),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home, size: 12.r, color: const Color(0xFF0F2D52)),
                        SizedBox(width: 4.w),
                        Text(
                          'Home Collection Available',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF0F2D52),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 16.h),
                _buildInfoRow(context, Icons.location_on_outlined, branch.address),
                SizedBox(height: 8.h),
                _buildInfoRow(context, Icons.phone_outlined, branch.phone),
                SizedBox(height: 8.h),
                _buildInfoRow(context, Icons.access_time_outlined, branch.workingHours),
              ],
            ),
          ),
          if (branch.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
              child: Image.network(
                branch.imageUrl!,
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120.h,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.map, color: Colors.grey)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16.r, color: const Color(0xFF1877F2)),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF0F2D52),
            ),
          ),
        ),
      ],
    );
  }
}
