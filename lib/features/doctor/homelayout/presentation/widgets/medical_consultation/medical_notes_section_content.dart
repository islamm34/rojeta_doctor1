import 'package:flutter/material.dart';

import '../../../../../../core/utils/screen_util_like.dart';
import 'medical_note_add_button.dart';
import 'medical_note_image_thumbnail.dart';
import 'medical_notes_empty_placeholder.dart';

class MedicalNotesSectionContent extends StatelessWidget {
  final List<String> images;
  final VoidCallback onAddImage;
  final void Function(int index) onRemoveImage;

  const MedicalNotesSectionContent({
    super.key,
    required this.images,
    required this.onAddImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return MedicalNotesEmptyPlaceholder(onTap: onAddImage);
    }

    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: [
        for (int i = 0; i < images.length; i++)
          MedicalNoteImageThumbnail(
            imagePath: images[i],
            onRemove: () => onRemoveImage(i),
          ),
        MedicalNoteAddButton(onTap: onAddImage),
      ],
    );
  }
}
