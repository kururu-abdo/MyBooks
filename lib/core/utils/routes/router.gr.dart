// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashScreenPageRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SplashScreenPage());
    },
    SignUpRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SignUp());
    },
    LoginFormRouter.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: LoginForm());
    },
    HomeRouter.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: Home());
    },
    HomeBodyRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomeBody());
    },
    AccountsRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const AccountsPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashScreenPageRouter.name, path: '/'),
        RouteConfig(SignUpRouter.name, path: '/signup'),
        RouteConfig(LoginFormRouter.name, path: '/login'),
        RouteConfig(HomeRouter.name, path: '/home', children: [
          RouteConfig(HomeBodyRoute.name, path: '', parent: HomeRouter.name),
          RouteConfig(AccountsRouter.name,
              path: 'accounts', parent: HomeRouter.name)
        ])
      ];
}

/// generated route for
/// [SplashScreenPage]
class SplashScreenPageRouter extends PageRouteInfo<void> {
  const SplashScreenPageRouter()
      : super(SplashScreenPageRouter.name, path: '/');

  static const String name = 'SplashScreenPageRouter';
}

/// generated route for
/// [SignUp]
class SignUpRouter extends PageRouteInfo<void> {
  const SignUpRouter() : super(SignUpRouter.name, path: '/signup');

  static const String name = 'SignUpRouter';
}

/// generated route for
/// [LoginForm]
class LoginFormRouter extends PageRouteInfo<void> {
  const LoginFormRouter() : super(LoginFormRouter.name, path: '/login');

  static const String name = 'LoginFormRouter';
}

/// generated route for
/// [Home]
class HomeRouter extends PageRouteInfo<void> {
  const HomeRouter({List<PageRouteInfo>? children})
      : super(HomeRouter.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [HomeBody]
class HomeBodyRoute extends PageRouteInfo<void> {
  const HomeBodyRoute() : super(HomeBodyRoute.name, path: '');

  static const String name = 'HomeBodyRoute';
}

/// generated route for
/// [AccountsPage]
class AccountsRouter extends PageRouteInfo<void> {
  const AccountsRouter() : super(AccountsRouter.name, path: 'accounts');

  static const String name = 'AccountsRouter';
}
