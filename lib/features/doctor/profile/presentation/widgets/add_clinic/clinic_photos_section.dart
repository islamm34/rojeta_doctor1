import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class ClinicPhotosSection extends StatelessWidget {
  final List<String> photos;
  final ValueChanged<List<String>>? onPhotosChanged;

  const ClinicPhotosSection({
    super.key,
    this.photos = const [],
    this.onPhotosChanged,
  });

  Future<void> _pickPhotos() async {
    if (photos.length >= 6) return;
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      final availableSlots = 6 - photos.length;
      final newPaths = pickedFiles
          .take(availableSlots)
          .map((file) => file.path)
          .toList();
      onPhotosChanged?.call([...photos, ...newPaths]);
    }
  }

  void _removePhoto(int index) {
    final updated = List<String>.from(photos)..removeAt(index);
    onPhotosChanged?.call(updated);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.clinicPhotos,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          strings.uploadUpTo6Photos,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        if (photos.isNotEmpty) ...[
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final photo = photos[index];
                final isNetwork =
                    photo.startsWith('http://') || photo.startsWith('https://');

                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: isNetwork
                            ? Image.network(photo, fit: BoxFit.cover)
                            : Image.file(File(photo), fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => _removePhoto(index),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (photos.length < 6)
          InkWell(
            onTap: _pickPhotos,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(8),
                color: theme.colorScheme.surface,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: theme.colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    strings.addPhoto,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
