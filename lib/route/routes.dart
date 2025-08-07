
import 'package:flutter_template/features/common/screens/pdf_viewer.dart';
import 'package:flutter_template/features/home/screens/home_screens.dart';
import 'package:flutter_template/features/tasbih/screens/tasbih_screens.dart';
import 'package:flutter_template/route/routes_name.dart';
import 'package:get/get.dart';

import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/splash/screens/splash_screen.dart';


class AppRoutes {

  static String getMainRoute(String page) => '${RouteName.homeView}?page=$page';
  static String openPdfRoute(String pdfUrl,String title) => '${RouteName.pdfView}?pdfUrl=$pdfUrl&title=$title';
  static String getTasbihScreen() => '${RouteName.tasbih}';


  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.homeView,
      page: () => DashboardScreen(pageIndex: Get.parameters['page'] == 'home'
          ? 0 : 0) ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.pdfView,
      page: () => PdfViewerPage(pdfUrl: Get.parameters['pdfUrl'] ?? "",title: Get.parameters['title'] ?? "",) ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.tasbih,
      page: () => TasbihScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    )
  ];

}