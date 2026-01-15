import 'package:flutter/material.dart';
import 'package:flutter_template/features/ads/screens/banner_ad.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfUrl;
  final String title;

  const PdfViewerPage({
    Key? key,
    required this.pdfUrl,
    required this.title,
  }) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
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
    _pdfViewerController = PdfViewerController();
    _checkFileType();
    _loadFile();
  }

  void _checkFileType() {
    final url = widget.pdfUrl.toLowerCase();

    setState(() {
      if (url.endsWith('.pdf')) {
        _isPdf = true;
        _hasError = false;
      } else if (url.endsWith('.jpg') ||
          url.endsWith('.jpeg') ||
          url.endsWith('.png') ||
          url.endsWith('.gif') ||
          url.endsWith('.bmp') ||
          url.endsWith('.webp')) {
        _isPdf = false; // It's an image
        _hasError = false;
      } else {
        _isPdf = false;
        _hasError = true;
        _errorMessage =
        'Unsupported file format. Please provide a PDF or image file.';
      }
    });
  }

  void _loadFile() {
    if (_hasError) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Simulate loading delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _retryLoading() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Loading file from: ${widget.pdfUrl}');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (!_isLoading && !_hasError && _isPdf)
            IconButton(
              icon: const Icon(Icons.zoom_in),
              onPressed: () {
                _pdfViewerController.zoomLevel = 2.0;
              },
            ),
          if (!_isLoading && !_hasError && _isPdf)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _pdfViewerController.jumpToPage(1);
              },
            ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BannerAdWidget(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return _buildLoadingState();
    } else if (_hasError) {
      return _buildErrorState();
    } else {
      if (_isPdf) {
        return _buildPdfViewer();
      } else {
        return _buildImageViewer();
      }
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: Container(
        color: Colors.grey[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 20),
            Text(
              'Loading Document...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const SizedBox(height: 20),
          Text(
            'Unable to load document',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'URL: ${widget.pdfUrl}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _retryLoading,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Retry'),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Go Back',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfViewer() {
    return SfPdfViewer.network(
      widget.pdfUrl,
      controller: _pdfViewerController,
      onDocumentLoaded: (PdfDocumentLoadedDetails details) {
        print('PDF document loaded successfully');
        print('Number of pages: ${details.document.pages.count}');
      },
      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
        print('Failed to load PDF document: ${details.error}');
        setState(() {
          _hasError = true;
          if (details.error.toString().contains('XMLHttpRequest')) {
            _errorMessage =
            'Network error. Please check your internet connection.';
          } else if (details.error.toString().contains('404')) {
            _errorMessage = 'PDF file not found. The URL may be incorrect.';
          } else {
            _errorMessage = 'Failed to load PDF: ${details.error.toString()}';
          }
        });
      },
    );
  }

  Widget _buildImageViewer() {
    return InteractiveViewer(
      panEnabled: true,
      minScale: 0.5,
      maxScale: 4,
      child: Center(
        child: Image.network(
          widget.pdfUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 10),
                  const Text(
                    'Failed to load image.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }
}
