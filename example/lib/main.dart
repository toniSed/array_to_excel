import 'package:flutter/material.dart';
import 'package:arrayToExcel/arrayToExcel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ArrayToExcel Example',
      home: ExcelDemoPage(),
    );
  }
}

class ExcelDemoPage extends StatefulWidget {
  const ExcelDemoPage({super.key});

  @override
  State<ExcelDemoPage> createState() => _ExcelDemoPageState();
}

class _ExcelDemoPageState extends State<ExcelDemoPage> {
  final List<String> headings = ['Name', 'Age', 'Country'];
  final List<List<dynamic>> data = [
    ['Alice', 30, 'USA'],
    ['Bob', 25, 'UK'],
    ['Charlie', 28, 'Canada'],
  ];

  Future<void> _saveExcel() async {
    final bytes = ArrayToExcel.generateExcel(headings: headings, data: data);
    if (bytes != null) {
      await ArrayToExcel.saveExcelFile(bytes: bytes, fileName: 'people.xlsx');
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Excel file saved!')));
      }
    }
  }

  Future<void> _shareExcel() async {
    final bytes = ArrayToExcel.generateExcel(headings: headings, data: data);
    if (bytes != null) {
      await ArrayToExcel.shareExcelFile(bytes: bytes, fileName: 'people.xlsx');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ArrayToExcel Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _saveExcel,
              child: const Text('Save Excel File'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _shareExcel,
              child: const Text('Share Excel File'),
            ),
          ],
        ),
      ),
    );
  }
}
