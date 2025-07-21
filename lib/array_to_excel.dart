library array_to_excel;

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'platform_file_saver.dart' if (dart.library.html) 'web_file_saver.dart';
import 'dart:io';

/// A class that provides functionality to convert arrays to Excel and save/share the file.
class ArrayToExcel {
  /// Generates an Excel file as a `Uint8List` from a list of headings and data rows.
  ///
  /// - [headings]: A list of strings representing the column titles.
  /// - [data]: A list of lists, where each inner list represents a row of data.
  /// - [sheetName]: The name of the sheet in the Excel file (defaults to 'Sheet1').
  static Uint8List? generateExcel({
    required List<String> headings,
    required List<List<dynamic>> data,
    String sheetName = 'Sheet1',
  }) {
    final excel = Excel.createExcel();
    final sheet = excel[sheetName];

    // Append header row
    sheet.appendRow(headings.map((e) => TextCellValue(e)).toList());

    // Append data rows
    for (final row in data) {
      sheet.appendRow(row.map((e) => TextCellValue(e.toString())).toList());
    }
    var fileBytes = excel.encode();
    if (fileBytes != null) {
      return Uint8List.fromList(fileBytes);
    }
    return null;
  }

  /// Saves the generated Excel file to the device.
  ///
  /// - [bytes]: The `Uint8List` data of the Excel file.
  /// - [fileName]: The name of the file to be saved (e.g., 'data.xlsx').
  static Future<void> saveExcelFile({
    required Uint8List bytes,
    String fileName = 'data.xlsx',
  }) async {
    await saveFile(bytes, fileName);
  }

  /// Shares the generated Excel file using the platform's share dialog.
  ///
  /// - [bytes]: The `Uint8List` data of the Excel file.
  /// - [fileName]: The name of the file to be shared (e.g., 'data.xlsx').
  /// - [subject]: The subject of the share (optional).
  static Future<void> shareExcelFile({
    required Uint8List bytes,
    String fileName = 'data.xlsx',
    String? subject,
  }) async {
    if (kIsWeb) {
      // Sharing is not supported on web.
      return;
    }
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/$fileName').writeAsBytes(bytes);
    final xFile = XFile(file.path,
        name: fileName,
        mimeType:
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    await Share.shareXFiles([xFile], subject: subject);
  }
}
