import 'package:flutter_test/flutter_test.dart';
import 'package:array_to_excel/array_to_excel.dart';
import 'dart:typed_data';
import 'package:excel/excel.dart';

void main() {
  test('Excel file generation returns non-empty bytes and correct headings',
      () {
    final headings = ['Name', 'Age', 'Country'];
    final data = [
      ['Alice', 30, 'USA'],
      ['Bob', 25, 'UK'],
    ];
    final Uint8List? bytes =
        ArrayToExcel.generateExcel(headings: headings, data: data);
    expect(bytes, isNotNull);
    expect(bytes!.isNotEmpty, true);
    final excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables[excel.tables.keys.first]!;
    final firstRow =
        sheet.rows.first.map((cell) => cell?.value.toString()).toList();
    expect(firstRow, headings);
  });
}
