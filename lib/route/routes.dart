
import 'package:flutter_template/features/common/screens/pdf_viewer.dart';
import 'package:flutter_template/features/home/domain/models/categories_model.dart';
import 'package:flutter_template/features/home/screens/home_screens.dart';
import 'package:flutter_template/features/qaza_namaz/screens/qaza_namaz_screen.dart';
import 'package:flutter_template/features/quraan/screens/quraan_screen.dart';
import 'package:flutter_template/features/tasbih/domain/models/read_tasbihs.dart';
import 'package:flutter_template/features/tasbih/screens/tasbih_counter_screen.dart';
import 'package:flutter_template/features/tasbih/screens/tasbih_screens.dart';
import 'package:flutter_template/features/zakat/screens/zakat_screen.dart';
import 'package:flutter_template/route/routes_name.dart';
import 'package:get/get.dart';

import '../features/common/screens/commig_soon.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/find_qibla/screens/find_qibla.dart';
import '../features/home/screens/categories.dart';
import '../features/quraan/screens/quraan_home_screen.dart';
import '../features/splash/screens/splash_screen.dart';


class AppRoutes {

  static String getMainRoute(String page) => '${RouteName.homeView}?page=$page';
  static String openPdfRoute(String pdfUrl,String title) => '${RouteName.pdfView}?pdfUrl=$pdfUrl&title=$title';
  static String getTasbihScreen() => '${RouteName.tasbih}';
  static String getQazaNamaz() => '${RouteName.qaza_namaz}';
  static String getTasbihCounterScreen() => RouteName.tasbih_counter;
  static String getFindQibla() => RouteName.find_qibla;
  static String getZakatScreen() => RouteName.zakat;
  static String getComingSoonScreen() => RouteName.cooming_soon;
  static String getQuraanScreen() => RouteName.quraanScreen;
  static String getQuraanPageScreen(String startPage,String endPage,String name) => '${RouteName.quraanPageScreen}?startPage=$startPage&endPage=$endPage&name=$name';
  static String getCategoriesScreen(int page_index) => '${RouteName.categories}?page_index=$page_index';


  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.quraanScreen,
      page: () => QuranParaSurahView() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.quraanPageScreen,
      page: () => QuraanPageView(startPage: Get.parameters['startPage'] ?? "",endPage: Get.parameters['endPage'] ?? "",name: Get.parameters['name'] ?? "",) ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.find_qibla,
      page: () => QiblaCompassApp() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.cooming_soon,
      page: () => ComingSoonScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.zakat,
      page: () => ZakatCalculatorPage() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.qaza_namaz,
      page: () => QazaNamazScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.categories,
     page: () => CategoryScreen(categories: int.tryParse(Get.parameters['page_index'] ?? '0') ?? 0 ) ,
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
      name: RouteName.tasbih_counter,
      page: () => TasbihCounterScreen(), // No parameters here
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteName.tasbih,
      page: () => TasbihScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    )
  ];

}