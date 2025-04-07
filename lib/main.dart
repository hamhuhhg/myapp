import 'dart:ui' as ui;
import 'package:day59/controllers/language/LanguageController.dart';
import 'package:day59/controllers/theme/ThemesController.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:day59/AppBinding.dart';
import 'package:day59/routes/routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Initialize GetStorage for persistent storage
  await GetStorage.init();

  // Ensure bindings are initialized before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for both Android and Web
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBPNGmS2WJd1EGNIX4XECtJOraPyvy0kkg",
        authDomain: "cityjucies.firebaseapp.com",
        databaseURL: "https://cityjucies-default-rtdb.firebaseio.com",
        projectId: "cityjucies",
        storageBucket: "cityjucies.firebasestorage.app",
        messagingSenderId: "615310209885",
        appId: "1:615310209885:web:03b1edde6f8663826beeb4",
        measurementId: "G-G79RZWGDL9"



    ),
  );

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Initialize controllers
  Get.put(ThemesController(), permanent: true);
  Get.put(LanguageController(), permanent: true);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('ar'),
      ],
      path: 'assets/lang', // Make sure this matches your translations directory
      fallbackLocale: const Locale('en'),
      child: Phoenix(child: const App()),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemesController themeController = Get.find();
    final LanguageController languageController = Get.find();

    return Directionality(
      textDirection: languageController.isRTL()
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter e-commerce app',
        theme: ThemesController().lightTheme,
        darkTheme: ThemesController().darkTheme,
        themeMode: _getThemeMode(themeController.theme.value),

        // EasyLocalization configuration
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        getPages: Routes.routes,
        initialRoute: '/splash',
        initialBinding: AppBinding(),
      ),
    );
  }

  ThemeMode _getThemeMode(String type) {
    switch (type) {
      case "dark":
        return ThemeMode.dark;
      case "system":
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}
