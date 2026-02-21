import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_template/route/routes.dart';
import 'package:flutter_template/utils/AppConstants.dart';
import 'package:flutter_template/utils/messages.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'features/language/controller/language_controller.dart';
import 'features/language/controller/theme_controller.dart';
import 'features/notification/domain/services/one_signal_service.dart';
import 'helpers/adhan_notification_service_helper.dart';
import 'helpers/get_di.dart' as di;
import 'locality/languages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("farukh-----");

  Map<String, Map<String, String>> languages = await di.init();
  await MobileAds.instance.initialize();


  if(GetPlatform.isWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyD0Z911mOoWCVkeGdjhIKwWFPRgvd6ZyAw",
        authDomain: "stackmart-500c7.firebaseapp.com",
        projectId: "stackmart-500c7",
        storageBucket: "stackmart-500c7.appspot.com",
        messagingSenderId: "491987943015",
        appId: "1:491987943015:web:d8bc7ab8dbc9991c8f1ec2"
    ));
  } else if(GetPlatform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA9vd-RwALm06KocqUbyDLbcutvwEctQ6I",
        appId: "1:1083971619329:android:31fc45637082d8cdd7ce00",
        messagingSenderId: "491987943015",
        projectId: "kartoon-videos",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  await GoogleSignIn.instance.initialize(
    serverClientId:
    '1083971619329-95mt1oh3k2jcvlice5elfvtekc0u0jc2.apps.googleusercontent.com',
  );
  handleError();
  runApp(MyApp(languages: languages));
}

class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>>? languages;

  const MyApp({super.key,required this.languages});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    OneSignalService.initOneSignal(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetBuilder<LocalizationController>(
      builder: (localizeController) {
        return GetBuilder<ThemeController>(
          builder: (themeController) {
            return GetMaterialApp(
              title: 'Flutter Demo',
              translations: Messages(languages: widget.languages),
              debugShowCheckedModeBanner: false,
              locale: localizeController.locale,
              fallbackLocale: Locale(
                  AppConstants.languages[0].languageCode!,
                  AppConstants.languages[0].countryCode),

              themeMode: themeController.themeMode,

              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: const Color(0xFF1F6F5B),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF1F6F5B),
                  foregroundColor: Colors.white,
                ),
              ),

              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: const Color(0xFF289672),
                scaffoldBackgroundColor: const Color(0xFF0B3D2E),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF0B3D2E),
                  foregroundColor: Colors.white,
                ),
              ),

              getPages: AppRoutes.appRoutes(),
            );
          },
        );
      },
    );

  }
}
void handleError() {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      print("Caught an error in a widget: ${details.exceptionAsString()}");
    }
    FlutterError.presentError(details);
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.error_outline_outlined, color: Colors.red, size: 34),
        const SizedBox(height: 10),
        const Text(
          'Oops! Something went wrong.',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          '${details.exception}',
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  };
}