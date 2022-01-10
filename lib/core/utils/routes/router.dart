import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mybooks/core/model/transaction.dart';
import 'package:mybooks/core/model/user.dart';
import 'package:mybooks/ui/screens/accountes.dart';
import 'package:mybooks/ui/screens/all_transactions.dart';
import 'package:mybooks/ui/screens/edit_profile.dart';
import 'package:mybooks/ui/screens/edit_transaction.dart';
import 'package:mybooks/ui/screens/home.dart';
import 'package:mybooks/ui/screens/home_body.dart';
import 'package:mybooks/ui/screens/login.dart';
import 'package:mybooks/ui/screens/new_account.dart';
import 'package:mybooks/ui/screens/profile.dart';
import 'package:mybooks/ui/screens/reportPage.dart';
import 'package:mybooks/ui/screens/search_page.dart';
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
        initial: true),
    AutoRoute(path: '/signup', page: SignUp, name: "SignUpRouter"),
    AutoRoute(path: '/login', page: LoginForm, name: "LoginFormRouter"),
    AutoRoute(
        path: '/trans', page: AllTransactions, name: "AllTransactionsRouter"),
    AutoRoute(
        path: '/edit_trans', page: EditTransaction, name: "EditTransRouter"),
    AutoRoute(path: '/search_page', page: SearchPage, name: "SearchPageRouter"),

    AutoRoute(
        path: '/edit_profile', page: EditProfile, name: "EditProfileRouter"),

    //EditProfile
    AutoRoute(path: '/home', page: Home, name: "HomeRouter", children: [
      AutoRoute(path: '', page: HomeBody, name: "HomeBodyRoute"),
      AutoRoute(path: 'report', page: ReportPage, name: "ReportPageRouter"),
      AutoRoute(path: 'accounts', page: AccountsPage, name: "AccountsRouter"),
      AutoRoute(path: 'profile', page: ProfilePage, name: "ProfilePageRouter"),

      //ProfilePage
    ]),
  ],
)
class AppRouter extends _$AppRouter {}
//flutter packages pub run build_runner build