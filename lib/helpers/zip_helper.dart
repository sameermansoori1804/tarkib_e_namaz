import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';

class ZipHelper {
  /// Download, extract, delete zip and return list of images
  static Future<List<File>> getImagesFromZip(
      String url, {
        String folderName = "images_cache",
        void Function(int received, int total)? onProgress,
      }) async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final extractPath = "${cacheDir.path}/$folderName";
      final dir = Directory(extractPath);

      // If already extracted → return cached images
      if (dir.existsSync()) {
        final files = dir
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) =>
        f.path.endsWith(".png") ||
            f.path.endsWith(".jpg") ||
            f.path.endsWith(".jpeg"))
            .toList();
        if (files.isNotEmpty) return files;
      }

      // Otherwise → download ZIP with progress
      final zipPath = "${cacheDir.path}/temp.zip";
      await Dio().download(
        url,
        zipPath,
        onReceiveProgress: onProgress, // 👈 progress callback
      );

      // Extract ZIP
      final bytes = File(zipPath).readAsBytesSync();
      final archive = ZipDecoder().decodeBytes(bytes);

      List<File> images = [];
      for (final file in archive) {
        if (file.isFile) {
          final filename = "$extractPath/${file.name}";
          final outFile = File(filename)..createSync(recursive: true);
          outFile.writeAsBytesSync(file.content as List<int>);
          if (filename.endsWith(".png") ||
              filename.endsWith(".jpg") ||
              filename.endsWith(".jpeg")) {
            images.add(outFile);
          }
        }
      }

      // Delete zip
      await File(zipPath).delete();
      return images;
    } catch (e) {
      print("❌ Error: $e");
      return [];
    }
  }

  /// Get images by range
  static Future<List<File>> getImagesByRange(
      String url,
      String start,
      String end, {
        String folderName = "images_cache",
        void Function(int received, int total)? onProgress,
      }) async {
    List<File> allImages =
    await getImagesFromZip(url, folderName: folderName, onProgress: onProgress);

    allImages.sort((a, b) => a.path.compareTo(b.path));
// Print file names after sorting
    print("\nFiles after sorting:");
    for (var file in allImages) {
      print("File: ${file.path.split('/').last}");
    }
    int startNum = int.parse(start.replaceAll(RegExp(r'[^0-9]'), ''));
    int endNum = int.parse(end.replaceAll(RegExp(r'[^0-9]'), ''));

    return allImages.where((file) {
      String name = file.uri.pathSegments.last.split('.').first;

      int num = int.tryParse(name.replaceAll(RegExp(r'[^0-9]'), '')) ?? -1;
      return num >= startNum && num <= endNum;
    }).toList();
  }
}
