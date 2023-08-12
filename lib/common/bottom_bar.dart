import 'package:amazon_clone/features/home/screen/home_screen.dart';
import 'package:amazon_clone/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../features/account/screens/account_screen.dart';

class ButtomNavBar extends StatefulWidget {
  static const String routeName = '/main-home';
  const ButtomNavBar({super.key});

  @override
  State<ButtomNavBar> createState() => _ButtomNavBarState();
}

class _ButtomNavBarState extends State<ButtomNavBar> {
  int _page = 0;
  double buttomNavItemWidth = 42;
  double bottomNavItemBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(
      child: Text("Shopping Cart Page"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        currentIndex: _page,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          //HOME
          BottomNavigationBarItem(
              icon: Container(
                width: buttomNavItemWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomNavItemBorderWidth,
                  )),
                ),
                child: Icon(Icons.home_outlined),
              ),
              label: ''),

          //ACCOUNT
          BottomNavigationBarItem(
              icon: Container(
                width: buttomNavItemWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomNavItemBorderWidth,
                  )),
                ),
                child: Icon(Icons.person_outline_outlined),
              ),
              label: ''),

          //CART
          BottomNavigationBarItem(
              icon: Container(
                width: buttomNavItemWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomNavItemBorderWidth,
                  )),
                ),
                child: const badges.Badge(
                  badgeContent: Text('4'),
                  badgeStyle:
                      badges.BadgeStyle(badgeColor: Colors.white, elevation: 0),
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              ),
              label: ''),
        ],
      ),
    );
  }
}
