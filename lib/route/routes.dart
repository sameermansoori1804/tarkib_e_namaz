
import 'package:flutter_template/features/auth/screens/sign_in_screen.dart';
import 'package:flutter_template/features/common/screens/pdf_viewer.dart';
import 'package:flutter_template/features/compitition/screens/competition_rules_screen.dart';
import 'package:flutter_template/features/compitition/screens/leader_board_screen.dart';
import 'package:flutter_template/features/compitition/screens/withdraw_screen.dart';
import 'package:flutter_template/features/home/domain/models/categories_model.dart';
import 'package:flutter_template/features/home/screens/SavedPdfListScreen.dart';
import 'package:flutter_template/features/home/screens/app_update_screen.dart';
import 'package:flutter_template/features/home/screens/home_screens.dart';
import 'package:flutter_template/features/language/screens/language_screen.dart';
import 'package:flutter_template/features/prayer_time/screens/notification_settings.dart';
import 'package:flutter_template/features/qaza_namaz/screens/qaza_namaz_screen.dart';
import 'package:flutter_template/features/quraan/screens/quraan_screen.dart';
import 'package:flutter_template/features/tasbih/domain/models/read_tasbihs.dart';
import 'package:flutter_template/features/tasbih/screens/normal_tasbih_screen.dart';
import 'package:flutter_template/features/tasbih/screens/tasbih_counter_screen.dart';
import 'package:flutter_template/features/tasbih/screens/tasbih_screens.dart';
import 'package:flutter_template/features/zakat/screens/zakat_screen.dart';
import 'package:flutter_template/route/routes_name.dart';
import 'package:get/get.dart';

import '../features/common/screens/commig_soon.dart';
import '../features/compitition/screens/competition_screen.dart';
import '../features/compitition/screens/profile_screen.dart';
import '../features/compitition/screens/wallet_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/find_qibla/screens/find_qibla.dart';
import '../features/home/screens/categories.dart';
import '../features/home/screens/web_view_screen.dart';
import '../features/quraan/screens/quraan_home_screen.dart';
import '../features/sawal_jawab/screens/SawalJawabScreen.dart';
import '../features/splash/screens/splash_screen.dart';


class AppRoutes {

  static String getMainRoute(String page) => '${RouteName.homeView}?page=$page';
  static String openPdfRoute(String pdfUrl,String title,{String isLocal = "no"}) => '${RouteName.pdfView}?pdfUrl=$pdfUrl&title=$title&is_local=$isLocal';
  static String getTasbihScreen() => '${RouteName.tasbih}';
  static String getQazaNamaz() => '${RouteName.qaza_namaz}';
  static String getTasbihCounterScreen() => RouteName.tasbih_counter;
  static String getFindQibla() => RouteName.find_qibla;
  static String getZakatScreen() => RouteName.zakat;
  static String getComingSoonScreen() => RouteName.cooming_soon;
  static String getAppUpdateScreen() => RouteName.appUpdateScreen;
  static String getCompetitionScreen() => RouteName.competitionScreen;
  static String getLeaderboardScreen() => RouteName.leaderboardScreen;
  static String getCompetitionRulesScreen() => RouteName.competitionRulesScreen;
  static String getWalletScreen() => RouteName.walletScreen;
  static String getLanguageScreen(String fromMenu) => '${RouteName.languageScreen}?from_menu=$fromMenu';
  static String getWithdrawScreen() => RouteName.withdrawScreen;
  static String getProfileScreen() => RouteName.profileScreen;
  static String getQuraanScreen() => RouteName.quraanScreen;
  static String getnormalTasbihScreen() => RouteName.normalTasbihScreen;
  static String getQuraanPageScreen(String startPage,String endPage,String name) => '${RouteName.quraanPageScreen}?startPage=$startPage&endPage=$endPage&name=$name';
  static String getCategoriesScreen(int page_index,String title) => '${RouteName.categories}?page_index=$page_index&title=$title';
  static String getWebView(String url,String title) => '${RouteName.webViewScreen}?url=$url&title=$title';
  static String getSavedPdfListScreen() => '${RouteName.savedPdfListScreen}';
  static String getNotificationSettings() => '${RouteName.notificationSettings}';


  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),GetPage(
      name: RouteName.appUpdateScreen,
      page: () => AppUpdateScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),GetPage(
      name: RouteName.leaderboardScreen,
      page: () => LeaderboardScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),GetPage(
      name: RouteName.notificationSettings,
      page: () => NotificationSettings() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),GetPage(
      name: RouteName.profileScreen,
      page: () => ProfileScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ), GetPage(
      name: RouteName.walletScreen,
      page: () => WalletScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),GetPage(
      name: RouteName.withdrawScreen,
      page: () => WithdrawScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),  GetPage(
      name: RouteName.competitionRulesScreen,
      page: () => CompetitionRulesScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ), GetPage(
      name: RouteName.normalTasbihScreen,
      page: () => NormalTasbihScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ), GetPage(
      name: RouteName.languageScreen,
      page: () => LanguageScreen(fromMenu:  Get.parameters['from_menu'] == "yes" ? true : false ) ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ), GetPage(
      name: RouteName.competitionScreen,
      page: () => CompetitionScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ), GetPage(
      name: RouteName.login,
      page: () => SignInScreen(exitFromApp: false, backFromThis: false) ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),    GetPage(name: RouteName.webViewScreen, page: () =>  WebViewScreen(url: Get.parameters['url'] ?? "",title:  Get.parameters['title'] ?? "",)),

    GetPage(
      name: RouteName.savedPdfListScreen,
      page: () => SavedPdfListScreen() ,
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
     page: () => CategoryScreen(categories: int.tryParse(Get.parameters['page_index'] ?? '0') ?? 0 ,title: Get.parameters['title'] ?? "") ,
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
      page: () => PdfViewerPage(pdfUrl: Get.parameters['pdfUrl'] ?? "",title: Get.parameters['title'] ?? "", isLocal:Get.parameters['is_local']  =="no" ? false : true ,) ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade ,
    ),
    GetPage(
      name: RouteName.sawalJawab,
      page: () => Sawaljawabscreen() ,
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