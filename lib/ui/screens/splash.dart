import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/ui/screens/home.dart';
import 'package:mybooks/ui/screens/login.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    startTime();
    // TODO: implement initState
    super.initState();
  }

  void navigationPage() {
    if (sharedPrefs.getLoginState()) {
      context.router.push(const HomeRouter());
    } else {
      context.router.push(const LoginFormRouter());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      screenFunction: () async {
        return Home();
      },
      splash: 'assets/images/logo.jpg',
      // nextScreen: AutoRouter(

      // ),
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.scale,
    );
  }
}
