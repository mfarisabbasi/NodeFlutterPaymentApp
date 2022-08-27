import 'package:banking_app/common/constants/global.dart';
import 'package:banking_app/screens/account_screen.dart';

import 'package:banking_app/screens/home_screen.dart';
import 'package:banking_app/screens/transaction/send_money_screen.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  static const String routeName = '/bottom-nav';
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  GlobalKey bottomNavigationKey = GlobalKey();
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const SendMoneyScreen(),
    const AccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.white,
        selectedBackgroundColor: GlobalVariables.secondaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: GlobalVariables.primaryColor,
        onTap: (int val) => setState(() => _page = val),
        currentIndex: _page,
        items: [
          FloatingNavbarItem(
            icon: Icons.area_chart_sharp,
            title: 'Dashboard',
          ),
          FloatingNavbarItem(
            icon: Icons.send_sharp,
            title: 'Send Money',
          ),
          FloatingNavbarItem(
            icon: Icons.account_box_sharp,
            title: 'Account',
          ),
        ],
      ),
    );
  }
}
