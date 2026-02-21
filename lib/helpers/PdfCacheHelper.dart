import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SavedPdf.dart';

class PdfCacheHelper {
  static const String _key = 'saved_pdfs';

  /// Download PDF and save locally
  static Future<File> downloadPdf(String url, String title) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to download PDF');
    }

    final dir = await getApplicationDocumentsDirectory();
    final fileName = title.replaceAll(' ', '_');
    final file = File('${dir.path}/$fileName.pdf');

    await file.writeAsBytes(response.bodyBytes);
    await _savePdfPath(title, file.path);

    return file;
  }

  /// Save PDF info to SharedPreferences
  static Future<void> _savePdfPath(String title, String path) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> list = prefs.getStringList(_key) ?? [];
     print("farukh----->");
     print(title);
    final pdf = SavedPdf(title: title, path: path);
    list.add(jsonEncode(pdf.toJson()));

    await prefs.setStringList(_key, list);
  }

  /// Get all saved PDFs
  static Future<List<SavedPdf>> getSavedPdfs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> list = prefs.getStringList(_key) ?? [];

    return list
        .map((e) => SavedPdf.fromJson(jsonDecode(e)))
        .toList();
  }
}
