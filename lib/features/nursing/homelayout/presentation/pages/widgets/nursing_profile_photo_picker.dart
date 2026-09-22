import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/image_picker_helper.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class NursingProfilePhotoPicker extends StatelessWidget {
  final String? imagePath;
  final ValueChanged<String?> onImagePicked;

  const NursingProfilePhotoPicker({
    super.key,
    required this.imagePath,
    required this.onImagePicked,
  });

  Future<void> _pickImage() async {
    final path = await ImagePickerHelper.pickImagePath();
    if (path != null) {
      onImagePicked(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final hasImage = imagePath != null && imagePath!.isNotEmpty;

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              children: [
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFCBD5E1),
                      width: 2,
                    ),
                    image: hasImage
                        ? DecorationImage(
                            image: FileImage(File(imagePath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: !hasImage
                      ? Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: const Color(0xFF64748B),
                            size: 32.w,
                          ),
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        hasImage ? Icons.edit : Icons.add,
                        color: Colors.white,
                        size: 18.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            s.uploadProfilePhoto,
            style: context.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
