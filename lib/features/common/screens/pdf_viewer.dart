import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../ads/screens/banner_ad.dart';

class PdfViewerPage extends StatelessWidget {
   String pdfUrl ;
   String title ;

  PdfViewerPage({required this.pdfUrl,required this.title});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('$title')),
      body: SfPdfViewer.network(pdfUrl),
        bottomNavigationBar: BannerAdWidget(),

    );
  }
}