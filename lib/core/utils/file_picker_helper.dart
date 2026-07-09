import 'package:file_picker/file_picker.dart';

/// A centralized helper for all file-picking operations using the
/// [file_picker] package. All methods are static; no instantiation needed.
class FilePickerHelper {
  FilePickerHelper._();

  // ─── Generic ────────────────────────────────────────────────────────────────

  /// Pick any single file and return its [PlatformFile], or `null` on cancel /
  /// error.
  static Future<PlatformFile?> pickFile({
    List<String>? allowedExtensions,
    FileType type = FileType.any,
  }) async {
    try {
      final result = await FilePicker.pickFiles(
        type: allowedExtensions != null ? FileType.custom : type,
        allowedExtensions: allowedExtensions,
        allowMultiple: false,
      );
      return result?.files.firstOrNull;
    } catch (_) {
      return null;
    }
  }

  /// Pick multiple files and return them as a [List<PlatformFile>] (empty on
  /// cancel / error).
  static Future<List<PlatformFile>> pickMultipleFiles({
    List<String>? allowedExtensions,
    FileType type = FileType.any,
  }) async {
    try {
      final result = await FilePicker.pickFiles(
        type: allowedExtensions != null ? FileType.custom : type,
        allowedExtensions: allowedExtensions,
        allowMultiple: true,
      );
      return result?.files ?? [];
    } catch (_) {
      return [];
    }
  }

  // ─── Typed shortcuts ─────────────────────────────────────────────────────────

  /// Pick a single PDF file.
  static Future<PlatformFile?> pickPdf() => pickFile(
        allowedExtensions: ['pdf'],
      );

  /// Pick a single image via the file system (not the photo gallery — use
  /// [ImagePickerHelper] for that).
  static Future<PlatformFile?> pickImage() => pickFile(
        allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'heic'],
      );

  /// Pick a single video file.
  static Future<PlatformFile?> pickVideo() => pickFile(
        allowedExtensions: ['mp4', 'mov', 'avi', 'mkv'],
      );

  /// Pick a single document (PDF, Word, Excel, PowerPoint).
  static Future<PlatformFile?> pickDocument() => pickFile(
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx'],
      );

  // ─── Convenience path accessors ──────────────────────────────────────────────

  /// Like [pickPdf] but returns the file path string directly (or `null`).
  static Future<String?> pickPdfPath() async {
    final file = await pickPdf();
    return file?.path;
  }

  /// Like [pickImage] but returns the file path string directly (or `null`).
  static Future<String?> pickImagePath() async {
    final file = await pickImage();
    return file?.path;
  }
}
