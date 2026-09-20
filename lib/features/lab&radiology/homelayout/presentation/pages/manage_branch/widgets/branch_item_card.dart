import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import '../../../../data/models/branch_model.dart';
import 'branch_info_row.dart';

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
                        branch.name ?? '-',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F2D52),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Color(0xFF7A8FA6),
                        size: 20,
                      ),
                      onPressed: onEdit,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(width: 12.w),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Color(0xFF7A8FA6),
                        size: 20,
                      ),
                      onPressed: onDelete,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
                if (branch.isHomeCollectionAvailable ?? false) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF45F5D0),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.home,
                          size: 12.r,
                          color: const Color(0xFF0F2D52),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          context.strings.homeCollectionAvailable,
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
                BranchInfoRow(
                  icon: Icons.location_on_outlined,
                  text: branch.address ?? '-',
                ),
                SizedBox(height: 6.h),
                BranchInfoRow(
                  icon: Icons.phone_outlined,
                  text: branch.phone ?? "-",
                ),
                SizedBox(height: 6.h),
                BranchInfoRow(
                  icon: Icons.access_time,
                  text: branch.workingHours ?? '0',
                ),
                if (branch.mapUrl != null)
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        height: 100.h,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.map, color: Colors.grey),
                        ),
                      ),
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
