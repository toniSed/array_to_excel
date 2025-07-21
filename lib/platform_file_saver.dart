import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

Future<void> saveFile(Uint8List bytes, String fileName) async {
  await FilePicker.platform.saveFile(
    dialogTitle: 'Please select a file',
    fileName: fileName,
    bytes: bytes,
  );
}
