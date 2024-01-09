// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart';

// Future<List<List<dynamic>>> readExcelFile(String filePath) async {
//   final file = File(filePath);
//   if (!file.existsSync()) {
//     throw Exception("File doesn't exist!");
//   }

//   final ByteData data = await file.readAsBytes().then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
//   final Workbook workbook = Workbook();
//  // workbook.openData(data);

//   final Worksheet sheet = workbook.worksheets[0];
//   final List<List<dynamic>> excelData = [];

//   for (int row = 1; row <= sheet.rows.length; row++) {
//     final List<dynamic> rowData = [];
//     for (int col = 1; col <= sheet.rows[row - 1].cells.length; col++) {
//       final cellValue = sheet.rows[row - 1].getCell(col).getValue();
//       rowData.add(cellValue);
//     }
//     excelData.add(rowData);
//   }

//   workbook.dispose();
//   return excelData;
// }
