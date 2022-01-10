import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/ui/screens/drawer.dart';
import 'package:mybooks/ui/screens/home_body.dart';
import 'package:mybooks/ui/widgets/app_title.dart';
import 'package:mybooks/ui/widgets/header.dart';
import 'package:mybooks/ui/widgets/home_last_process_lable.dart';
import 'package:mybooks/ui/widgets/home_min_transaction_shimmer.dart';
import 'package:mybooks/ui/widgets/process_button_widget.dart';
import 'package:mybooks/ui/widgets/transaction_lists.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:unicons/unicons.dart';

class Home extends StatefulWidget {
  Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showButtomSheet = false;

  void updateBottomSheetState() {
    setState(() {
      _showButtomSheet = !_showButtomSheet;
    });
  }

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context);
    // return Scaffold(
    //     appBar: AppBar(title: Text('Dashboard page')),
    //     // this inserts a new router scope into the widgets tree
    //     body: AutoRouter());
    // return AutoTabsRouter(
    //   // list of your tab routes
    //   // routes used here must be declaraed as children
    //   // routes of /dashboard
    //   routes: const [
    //     HomeRouter(),
    //     HomeBodyRoute(),
    //   ],
    //   builder: (context, child, animation) {
    //     // obtain the scoped TabsRouter controller using context
    //     final tabsRouter = AutoTabsRouter.of(context);
    //     // Here we're building our Scaffold inside of AutoTabsRouter
    //     // to access the tabsRouter controller provided in this context
    //     //
    //     //alterntivly you could use a global key
    //     return Scaffold(
    //         body: FadeTransition(
    //           opacity: animation,
    //           // the passed child is techinaclly our animated selected-tab page
    //           child: child,
    //         ),
    //         bottomNavigationBar: BottomNavigationBar(
    //           currentIndex: tabsRouter.activeIndex,
    //           onTap: (index) {
    //             // here we switch between tabs
    //             tabsRouter.setActiveIndex(index);
    //           },
    //           items: [
    //             BottomNavigationBarItem(label: 'Users', icon: Icon(Icons.home)),
    //             BottomNavigationBarItem(label: 'Users', icon: Icon(Icons.home)),
    //           ],
    //         ));
    //   },
    // );
    return SafeArea(
      child: AutoTabsScaffold(
        backgroundColor: _showButtomSheet ? Colors.grey : Colors.white,
        routes: const [
          HomeBodyRoute(),
          ReportPageRouter(),
          AccountsRouter(),
          ProfilePageRouter(),
        ],

        builder: (context, child, animation) {
          // obtain the scoped TabsRouter controller using context
          final tabsRouter = AutoTabsRouter.of(context);
          // Here we're building our Scaffold inside of AutoTabsRouter
          // to access the tabsRouter controller provided in this context
          //
          //alterntivly you could use a global key
          return Scaffold(
              body: FadeTransition(
            opacity: animation,
            // the passed child is techinaclly our animated selected-tab page
            child: child,
          ));
        },
        bottomNavigationBuilder: (_, tabsRouter) {
          return SalomonBottomBar(
            // margin: const EdgeInsets.symmetric(
            //   horizontal: 20,
            //   vertical: 40,
            // ),
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              SalomonBottomBarItem(
                //     selectedColor: Colors.amberAccent,
                icon: const Icon(
                  Icons.home,
                  size: 30,
                ),
                title: const Text('الرئيسية'),
              ),
              SalomonBottomBarItem(
                //     selectedColor: Colors.amberAccent,
                icon: const Icon(
                  Icons.show_chart,
                  size: 30,
                ),
                title: const Text('ملخص'),
              ),
              SalomonBottomBarItem(
                //     selectedColor: Colors.amberAccent,
                icon: const Icon(
                  Icons.account_balance_wallet_sharp,
                  size: 30,
                ),
                title: const Text('الحسابات'),
              ),
              SalomonBottomBarItem(
                //      selectedColor: Colors.blue[200],
                icon: const Icon(
                  Icons.face,
                  size: 30,
                ),
                title: const Text('الملف الشخصي'),
              ),
            ],
          );
        },
        // builder: (context, child, animation) => Scaffold(
        //   body: Column(
        //     children: [
        //       Header(
        //         onMenueIconPressed: updateBottomSheetState,
        //       ),
        //       HomeBody()
        //     ],
        //   ),
        // ),
        bottomSheet:
            Visibility(visible: _showButtomSheet, child: DrawerIcomns()),
      ),
    );
  }

  voidshaowBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: DrawerIcomns()),
    );
  }
}
