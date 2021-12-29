import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mybooks/ui/screens/accountes.dart';
import 'package:mybooks/ui/screens/home.dart';
import 'package:mybooks/ui/screens/home_body.dart';
import 'package:mybooks/ui/screens/login.dart';
import 'package:mybooks/ui/screens/new_account.dart';
import 'package:mybooks/ui/screens/signup.dart';
import 'package:mybooks/ui/screens/splash.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: SplashScreenPage,
      name: "SplashScreenPageRouter",
      initial: true
    ),
    AutoRoute(
        path: '/signup',
        page: SignUp,
        name: "SignUpRouter"),
     AutoRoute(
        path: '/login',
        page: LoginForm,
        name: "LoginFormRouter"),
    AutoRoute(
        path: '/home',
        page: Home,
        name: "HomeRouter",
   
      
        children: [
          AutoRoute(path: '', page: HomeBody, name: "HomeBodyRoute"),
          AutoRoute(path: 'accounts', page: AccountsPage, name: "AccountsRouter"),
        ]),
  ],
)
class AppRouter extends _$AppRouter {}
//flutter packages pub run build_runner build