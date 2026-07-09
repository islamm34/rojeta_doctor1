import 'package:image_picker/image_picker.dart';

/// A centralized helper for all image / video picking operations using the
/// [image_picker] package. All methods are static; no instantiation needed.
class ImagePickerHelper {
  ImagePickerHelper._();

  static final ImagePicker _picker = ImagePicker();

  // ─── Image ───────────────────────────────────────────────────────────────────

  /// Pick a single image from the [source] (defaults to gallery) and return
  /// its [XFile], or `null` on cancel / error.
  static Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    try {
      return await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
    } catch (_) {
      return null;
    }
  }

  /// Pick a single image from the camera.
  static Future<XFile?> pickFromCamera({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) =>
      pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

  /// Pick a single image from the gallery.
  static Future<XFile?> pickFromGallery({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) =>
      pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

  /// Pick multiple images from the gallery.
  static Future<List<XFile>> pickMultipleImages({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    try {
      return await _picker.pickMultiImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
    } catch (_) {
      return [];
    }
  }

  // ─── Video ───────────────────────────────────────────────────────────────────

  /// Pick a single video from the [source] (defaults to gallery) and return
  /// its [XFile], or `null` on cancel / error.
  static Future<XFile?> pickVideo({
    ImageSource source = ImageSource.gallery,
    Duration? maxDuration,
  }) async {
    try {
      return await _picker.pickVideo(
        source: source,
        maxDuration: maxDuration,
      );
    } catch (_) {
      return null;
    }
  }

  /// Pick a video from the camera.
  static Future<XFile?> pickVideoFromCamera({Duration? maxDuration}) =>
      pickVideo(source: ImageSource.camera, maxDuration: maxDuration);

  // ─── Convenience path accessors ──────────────────────────────────────────────

  /// Like [pickImage] but returns the file path string directly (or `null`).
  static Future<String?> pickImagePath({
    ImageSource source = ImageSource.gallery,
  }) async {
    final file = await pickImage(source: source);
    return file?.path;
  }

  /// Like [pickFromCamera] but returns the file path string directly (or `null`).
  static Future<String?> pickFromCameraPath() async {
    final file = await pickFromCamera();
    return file?.path;
  }
}
