import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttersqlite/core/utils/navigator_service.dart';
import 'package:fluttersqlite/localization/app_localization.dart';
import 'package:fluttersqlite/theme/theme_helper.dart';
import 'package:fluttersqlite/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'fluttersqlite',
      navigatorKey: NavigatorService.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreen,
      routes: AppRoutes.routes,
         localizationsDelegates: [
        AppLocalizationDelegate(),
      ],
        supportedLocales: [
        Locale(
          'en',
          '',
        ),
      ],
    );
  }
}
