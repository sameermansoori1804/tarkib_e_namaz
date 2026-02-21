import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/widgets/comman_app_bar.dart';
import 'package:get/get.dart';
import 'package:page_flip/page_flip.dart';
import '../../../helpers/zip_helper.dart';

class QuraanPageView extends StatefulWidget {
  String startPage;
  String endPage;
  String name;
   QuraanPageView({required this.startPage,required this.endPage,required this.name});

  @override
  State<QuraanPageView> createState() => _QuraanPageViewState();
}

class _QuraanPageViewState extends State<QuraanPageView> {
  double progress = 0.0;
  List<File> images = [];
  final GlobalKey<PageFlipWidgetState> _controller = GlobalKey<PageFlipWidgetState>();

  @override
  void initState() {
    super.initState();
    getSpecificImages();
  }

  void getSpecificImages() async {
    String zipUrl = "http://tarkibenamaz.visticsolutions.in/public/qurran/images_quran.zip";
    List<File> result = await ZipHelper.getImagesByRange(
      zipUrl,
      widget.startPage,
      widget.endPage,
      onProgress: (received, total) {
        if (total != -1) {
          setState(() {
            progress = received / total;
          });
        }
      },
    );

    print(result.length);
    print("farukh----");

    setState(() {
      images = result;
      progress = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (progress < 1.0) {
      return Scaffold(
        appBar: CommanAppBar(title: "${widget.name}"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(value: progress),
              const SizedBox(height: 10),
              Text("${(progress * 100).toStringAsFixed(0)}%"),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CommanAppBar(title: "${widget.name}"),
      body: Directionality(
        textDirection: TextDirection.rtl, // RTL for Quraan
        child: PageFlipWidget(
          key: _controller,
          isRightSwipe: true,
          backgroundColor: Colors.white,
          lastPage: Container(
            color: Colors.white,
            child:  Center(child: Text('last_page'.tr)),
          ),
          children: images.map((image) {
            return Container(
              color: Colors.white,
              child: Image.file(
                image,
                fit: BoxFit.contain,
              ),
            );
          }).toList(),
          
        ),
      ),
    );
  }
}