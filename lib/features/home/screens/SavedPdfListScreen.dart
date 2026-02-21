import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/PdfCacheHelper.dart';
import '../../../helpers/SavedPdf.dart';
import '../../../route/routes.dart';

class SavedPdfListScreen extends StatefulWidget {
  const SavedPdfListScreen({super.key});

  @override
  State<SavedPdfListScreen> createState() => _SavedPdfListScreenState();
}

class _SavedPdfListScreenState extends State<SavedPdfListScreen> {
  late Future<List<SavedPdf>> _pdfs;

  @override
  void initState() {
    super.initState();
    _pdfs = PdfCacheHelper.getSavedPdfs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F3),
      body: SafeArea(
        child: FutureBuilder<List<SavedPdf>>(
          future: _pdfs,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF1E6F5C)),
              );
            }
        
            if (snapshot.data!.isEmpty) {
              return _emptyState();
            }
        
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pdf = snapshot.data![index];
        
                return _pdfCard(pdf);
              },
            );
          },
        ),
      ),
    );
  }

  /// 📄 PDF Card UI
  Widget _pdfCard(SavedPdf pdf) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF1E6F5C).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.picture_as_pdf,
            color: Color(0xFF1E6F5C),
            size: 28,
          ),
        ),
        title: Text(
          pdf.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle:  Text(
          'tap_to_open'.tr,
          style: TextStyle(fontSize: 13),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {
          Get.toNamed(AppRoutes.openPdfRoute(pdf.path ?? "",pdf.title ?? "")); // Replace with your HomeScreen route

          // Navigate to PDF viewer
        },
      ),
    );
  }

  /// 🌙 Empty State UI
  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.menu_book_outlined,
              size: 90,
              color: Color(0xFF1E6F5C),
            ),
            const SizedBox(height: 20),
            Text(
              'no_saved_pdfs'.tr, // 🔹 translated
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'saved_pdfs_description'.tr, // 🔹 translated
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
