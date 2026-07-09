import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  static Future<String?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles();
      if (result != null && result.files.single.path != null) {
        return result.files.single.path;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
