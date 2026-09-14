import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/consultation_draft_model.dart';

class ConsultationDraftLocalDataSource {
  ConsultationDraftLocalDataSource._();

  static const String _boxName = 'consultation_drafts_box';

  static Future<Box<String>> _getBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<String>(_boxName);
    }
    return await Hive.openBox<String>(_boxName);
  }

  static Future<Directory> _getDraftDirectory(String appointmentId) async {
    final appDir = await getApplicationDocumentsDirectory();
    final dir = Directory('${appDir.path}/consultation_drafts/$appointmentId');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  /// Copies a file into the app's persistent draft directory if it is not already there.
  static Future<String?> _persistFile({
    required String? sourcePath,
    required String appointmentId,
    required String prefix,
  }) async {
    if (sourcePath == null || sourcePath.isEmpty) return null;
    final file = File(sourcePath);
    if (!await file.exists()) return null;

    final draftDir = await _getDraftDirectory(appointmentId);
    if (file.path.startsWith(draftDir.path)) {
      return file.path;
    }

    final originalName = file.uri.pathSegments.isNotEmpty
        ? file.uri.pathSegments.last
        : 'file';
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final targetPath = '${draftDir.path}/${prefix}_${timestamp}_$originalName';
    final copiedFile = await file.copy(targetPath);
    return copiedFile.path;
  }

  /// Copies all medical note images into the draft directory so they remain available.
  static Future<List<String>> _persistImages({
    required List<String> sourcePaths,
    required String appointmentId,
  }) async {
    final List<String> result = [];
    final draftDir = await _getDraftDirectory(appointmentId);

    for (int i = 0; i < sourcePaths.length; i++) {
      final path = sourcePaths[i];
      final file = File(path);
      if (!await file.exists()) continue;

      if (file.path.startsWith(draftDir.path)) {
        result.add(file.path);
      } else {
        final ext = file.path.contains('.') ? file.path.split('.').last : 'jpg';
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final targetPath = '${draftDir.path}/note_${timestamp}_$i.$ext';
        final copied = await file.copy(targetPath);
        result.add(copied.path);
      }
    }

    return result;
  }

  /// Saves consultation draft and ensures all files and images are persisted locally.
  static Future<ConsultationDraftModel> saveDraft({
    required String appointmentId,
    String? diagnosis,
    String? medicationDetails,
    String? laboratoryTests,
    String? radiologyTests,
    String? followUpDate,
    bool isConsultationStarted = false,
    PlatformFile? pickedPdf,
    PlatformFile? pickedLabDocument,
    PlatformFile? pickedRadiologyDocument,
    List<String> medicalNotesImages = const [],
  }) async {
    final persistedPdfPath = await _persistFile(
      sourcePath: pickedPdf?.path,
      appointmentId: appointmentId,
      prefix: 'pdf',
    );

    final persistedLabPath = await _persistFile(
      sourcePath: pickedLabDocument?.path,
      appointmentId: appointmentId,
      prefix: 'lab',
    );

    final persistedRadiologyPath = await _persistFile(
      sourcePath: pickedRadiologyDocument?.path,
      appointmentId: appointmentId,
      prefix: 'rad',
    );

    final persistedImages = await _persistImages(
      sourcePaths: medicalNotesImages,
      appointmentId: appointmentId,
    );

    // Clean up orphaned files in draft directory
    final activePaths = {
      ?persistedPdfPath,
      ?persistedLabPath,
      ?persistedRadiologyPath,
      ...persistedImages,
    };

    try {
      final draftDir = await _getDraftDirectory(appointmentId);
      if (await draftDir.exists()) {
        await for (final entity in draftDir.list()) {
          if (entity is File && !activePaths.contains(entity.path)) {
            try {
              await entity.delete();
            } catch (_) {}
          }
        }
      }
    } catch (e, st) {
      log('Error cleaning orphaned draft files: $e\n$st');
    }

    final draft = ConsultationDraftModel(
      appointmentId: appointmentId,
      diagnosis: diagnosis,
      medicationDetails: medicationDetails,
      laboratoryTests: laboratoryTests,
      radiologyTests: radiologyTests,
      followUpDate: followUpDate,
      isConsultationStarted: isConsultationStarted,
      prescriptionPdfPath: persistedPdfPath,
      prescriptionPdfName: pickedPdf?.name,
      laboratoryTestsDocumentPath: persistedLabPath,
      laboratoryTestsDocumentName: pickedLabDocument?.name,
      radiologyTestsDocumentPath: persistedRadiologyPath,
      radiologyTestsDocumentName: pickedRadiologyDocument?.name,
      medicalNotesImagePaths: persistedImages,
      savedAt: DateTime.now(),
    );

    final box = await _getBox();
    await box.put(appointmentId, draft.toJson());

    return draft;
  }

  /// Loads the saved draft for the given appointment, if any exists.
  static Future<ConsultationDraftModel?> getDraft(String appointmentId) async {
    try {
      final box = await _getBox();
      final jsonString = box.get(appointmentId);
      if (jsonString == null || jsonString.isEmpty) return null;

      return ConsultationDraftModel.fromJson(jsonString);
    } catch (e, st) {
      log('Error getting consultation draft: $e\n$st');
      return null;
    }
  }

  /// Clears the draft and any stored draft files for the given appointment.
  static Future<void> clearDraft(String appointmentId) async {
    try {
      final box = await _getBox();
      await box.delete(appointmentId);

      final draftDir = await _getDraftDirectory(appointmentId);
      if (await draftDir.exists()) {
        await draftDir.delete(recursive: true);
      }
    } catch (e, st) {
      log('Error clearing consultation draft: $e\n$st');
    }
  }
}
