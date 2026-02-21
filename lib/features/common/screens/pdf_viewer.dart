import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/features/ads/screens/banner_ad.dart';
import 'package:flutter_template/helpers/PdfCacheHelper.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfUrl; // URL or local file path
  final String title;
  final bool isLocal;

  const PdfViewerPage({
    Key? key,
    required this.pdfUrl,
    required this.title,
    this.isLocal = false,
  }) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PdfViewerController _pdfViewerController;

  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  bool _isPdf = true;

  @override
  void initState() {
    super.initState();

    print(widget.pdfUrl);
    print(widget.isLocal);
    print("farukh----->");
    _pdfViewerController = PdfViewerController();

    // 🕌 Full screen immersive Islamic reading
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    _checkFileType();
  }

  void _checkFileType() {
    final path = widget.pdfUrl.toLowerCase();

    if (path.endsWith('.pdf')) {
      _isPdf = true;
    } else if (path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.png') ||
        path.endsWith('.webp') ||
        path.endsWith('.gif')) {
      _isPdf = false;
    } else {
      _hasError = true;
      _errorMessage = 'unsupported_file_format'.tr;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F3),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E6F5C),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          if (_isPdf && !widget.isLocal)
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                PdfCacheHelper.downloadPdf(
                  widget.pdfUrl,
                  widget.title,
                );
              },
            ),
        ],
      ),

      body: _buildBody(),

      // Ads hidden while reading local PDFs
      bottomNavigationBar:
      widget.isLocal ? null :  BannerAdWidget(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return _loadingView();
    if (_hasError) return _errorView();

    return _isPdf ? _pdfViewer() : _imageViewer();
  }

  // 📖 PDF VIEWER (FAST LOAD)
  Widget _pdfViewer() {
    if (widget.isLocal) {
      return SfPdfViewer.file(
        File(widget.pdfUrl),
        controller: _pdfViewerController,
        enableDoubleTapZooming: true,
      );
    }

    return SfPdfViewer.network(
      widget.pdfUrl,
      controller: _pdfViewerController,
      canShowPaginationDialog: false,
      onDocumentLoaded: (_) {
        setState(() => _isLoading = false);
      },
      onDocumentLoadFailed: (details) {
        setState(() {
          _hasError = true;
          _errorMessage = 'failed_to_load_pdf'.tr;
        });
      },
    );
  }

  // 🖼 Image Viewer
  Widget _imageViewer() {
    return InteractiveViewer(
      minScale: 1,
      maxScale: 5,
      child: Center(
        child: widget.isLocal
            ? Image.file(
          File(widget.pdfUrl),
          fit: BoxFit.contain,
          gaplessPlayback: true,
        )
            : Image.network(
          widget.pdfUrl,
          fit: BoxFit.contain,
          gaplessPlayback: true,
        ),
      ),
    );
  }

  // 🌙 Loading UI
  Widget _loadingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xFF1E6F5C),
            strokeWidth: 3,
          ),
          SizedBox(height: 20),
          Text(
            'preparing_document',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ❌ Error UI
  Widget _errorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 70, color: Colors.redAccent),
            const SizedBox(height: 20),
            Text(
              'unable_to_open_document'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E6F5C),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('go_back'.tr),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    _pdfViewerController.dispose();
    super.dispose();
  }
}