import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/models/staff_model.dart';

class SpecialtyStaffItem extends StatelessWidget {
  final StaffModel staff;
  final VoidCallback? onEdit;
  final VoidCallback? onProfile;

  const SpecialtyStaffItem({
    super.key,
    required this.staff,
    this.onEdit,
    this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: staff.imagePath != null
                ? AssetImage(staff.imagePath!)
                : null,
            child: staff.imagePath == null ? const Icon(Icons.person) : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  staff.name,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${staff.price} . ${staff.availability}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.grey, size: 20),
            onPressed: onEdit ?? () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: Colors.grey,
              size: 20,
            ),
            onPressed: onProfile ?? () {},
          ),
        ],
      ),
    );
  }
}
