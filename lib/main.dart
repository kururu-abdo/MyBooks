import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/viewmodels/theme_viewmodel.dart';
import 'package:mybooks/locstor.dart';
import 'package:mybooks/ui/screens/home.dart';
import 'package:mybooks/ui/screens/login.dart';
import 'package:mybooks/ui/screens/new_account.dart';
import 'package:mybooks/ui/screens/new_transaction.dart';
import 'package:stacked/stacked.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  regiderServices();

  HttpOverrides.global = MyHttpOverrides();
  await SharedPrefs.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = locator.get<AppRouter>();

    return ViewModelBuilder<ThemeViewModel>.reactive(
        viewModelBuilder: () => ThemeViewModel(),
        builder: (context, model, child) {
          return MaterialApp.router(
            routerDelegate: AutoRouterDelegate(router),
            routeInformationParser: router.defaultRouteParser(),
            title: 'my book',
            theme: model.getTheme,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: const Locale("ar", "KSA"),
            supportedLocales: const [Locale("ar", "KSA"), Locale("en", "")],
            //home: LoginForm(),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final appRouter = AppRouter();
var nav = locator.get<AppRouter>();
