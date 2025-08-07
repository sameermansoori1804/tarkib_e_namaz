import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/route/routes.dart';
import 'package:flutter_template/utils/AppConstants.dart';
import 'package:flutter_template/utils/messages.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'features/language/controller/language_controller.dart';
import 'helpers/get_di.dart' as di;
import 'locality/languages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Map<String, Map<String, String>> languages = await di.init();
  await MobileAds.instance.initialize();

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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetBuilder<LocalizationController>(builder: (localizeController) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        translations: Messages(languages: widget.languages),
        locale: localizeController.locale,
        fallbackLocale: Locale(
            AppConstants.languages[0].languageCode!,
            AppConstants.languages[0].countryCode),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        getPages: AppRoutes.appRoutes(),
      );
    });

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