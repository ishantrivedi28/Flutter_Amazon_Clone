import 'package:amazon_clone/features/admin/screens/product_screen.dart';
import 'package:flutter/material.dart';

import '../../../global_variables.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double buttomNavItemWidth = 42;
  double bottomNavItemBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    ProductScreen(),
    const Center(
      child: Text("Shopping Cart Page"),
    ),
    const Center(
      child: Text("Shopping Cart Page"),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/amazon_in.png',
                width: 120,
                height: 45,
                color: Colors.black,
              ),
            ),
            const Text(
              'Admin',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            )
          ]),
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
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
                child: Icon(Icons.analytics_outlined),
              ),
              label: ''),

          //ORDERSS
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
                child: Icon(Icons.all_inbox_outlined),
              ),
              label: ''),
        ],
      ),
    );
  }
}
