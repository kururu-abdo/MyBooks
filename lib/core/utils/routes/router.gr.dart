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
    AllTransactionsRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const AllTransactions());
    },
    EditTransRouter.name: (routeData) {
      final args = routeData.argsAs<EditTransRouterArgs>(
          orElse: () => const EditTransRouterArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: EditTransaction(key: args.key, transaction: args.transaction));
    },
    SearchPageRouter.name: (routeData) {
      final args = routeData.argsAs<SearchPageRouterArgs>(
          orElse: () => const SearchPageRouterArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: SearchPage(key: args.key, user: args.user));
    },
    EditProfileRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EditProfile());
    },
    HomeRouter.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: Home());
    },
    HomeBodyRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomeBody());
    },
    ReportPageRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ReportPage());
    },
    AccountsRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const AccountsPage());
    },
    ProfilePageRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ProfilePage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashScreenPageRouter.name, path: '/'),
        RouteConfig(SignUpRouter.name, path: '/signup'),
        RouteConfig(LoginFormRouter.name, path: '/login'),
        RouteConfig(AllTransactionsRouter.name, path: '/trans'),
        RouteConfig(EditTransRouter.name, path: '/edit_trans'),
        RouteConfig(SearchPageRouter.name, path: '/search_page'),
        RouteConfig(EditProfileRouter.name, path: '/edit_profile'),
        RouteConfig(HomeRouter.name, path: '/home', children: [
          RouteConfig(HomeBodyRoute.name, path: '', parent: HomeRouter.name),
          RouteConfig(ReportPageRouter.name,
              path: 'report', parent: HomeRouter.name),
          RouteConfig(AccountsRouter.name,
              path: 'accounts', parent: HomeRouter.name),
          RouteConfig(ProfilePageRouter.name,
              path: 'profile', parent: HomeRouter.name)
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
/// [AllTransactions]
class AllTransactionsRouter extends PageRouteInfo<void> {
  const AllTransactionsRouter()
      : super(AllTransactionsRouter.name, path: '/trans');

  static const String name = 'AllTransactionsRouter';
}

/// generated route for
/// [EditTransaction]
class EditTransRouter extends PageRouteInfo<EditTransRouterArgs> {
  EditTransRouter({Key? key, Transaction? transaction})
      : super(EditTransRouter.name,
            path: '/edit_trans',
            args: EditTransRouterArgs(key: key, transaction: transaction));

  static const String name = 'EditTransRouter';
}

class EditTransRouterArgs {
  const EditTransRouterArgs({this.key, this.transaction});

  final Key? key;

  final Transaction? transaction;

  @override
  String toString() {
    return 'EditTransRouterArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [SearchPage]
class SearchPageRouter extends PageRouteInfo<SearchPageRouterArgs> {
  SearchPageRouter({Key? key, User? user})
      : super(SearchPageRouter.name,
            path: '/search_page',
            args: SearchPageRouterArgs(key: key, user: user));

  static const String name = 'SearchPageRouter';
}

class SearchPageRouterArgs {
  const SearchPageRouterArgs({this.key, this.user});

  final Key? key;

  final User? user;

  @override
  String toString() {
    return 'SearchPageRouterArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [EditProfile]
class EditProfileRouter extends PageRouteInfo<void> {
  const EditProfileRouter()
      : super(EditProfileRouter.name, path: '/edit_profile');

  static const String name = 'EditProfileRouter';
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
/// [ReportPage]
class ReportPageRouter extends PageRouteInfo<void> {
  const ReportPageRouter() : super(ReportPageRouter.name, path: 'report');

  static const String name = 'ReportPageRouter';
}

/// generated route for
/// [AccountsPage]
class AccountsRouter extends PageRouteInfo<void> {
  const AccountsRouter() : super(AccountsRouter.name, path: 'accounts');

  static const String name = 'AccountsRouter';
}

/// generated route for
/// [ProfilePage]
class ProfilePageRouter extends PageRouteInfo<void> {
  const ProfilePageRouter() : super(ProfilePageRouter.name, path: 'profile');

  static const String name = 'ProfilePageRouter';
}
