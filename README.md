# arrayToExcel

A Flutter package to easily generate Excel files from arrays of headings and data, and allow users to save or share the file on Android, iOS, Web, and Desktop platforms.

## Features
- Generate Excel files from a list of headings and data rows
- Save the Excel file to a user-selected location (mobile, desktop, web)
- Share the Excel file using the platform share dialog (mobile, desktop)

## Supported Platforms
- Android
- iOS
- Web (save only, sharing not supported)
- Windows
- macOS
- Linux

## Usage

```dart
import 'package:arrayToExcel/arrayToExcel.dart';
import 'dart:typed_data';

final headings = ['Name', 'Age', 'Country'];
final data = [
  ['Alice', 30, 'USA'],
  ['Bob', 25, 'UK'],
  ['Charlie', 28, 'Canada'],
];

// Generate Excel bytes
final bytes = ArrayToExcel.generateExcel(headings: headings, data: data);

if (bytes != null) {
  // Save the file
  await ArrayToExcel.saveExcelFile(bytes: bytes, fileName: 'people.xlsx');

  // Or share the file
  await ArrayToExcel.shareExcelFile(bytes: bytes, fileName: 'people.xlsx');
}
```

## Example
See the `example/` directory for a complete usage example.

## License
MIT
