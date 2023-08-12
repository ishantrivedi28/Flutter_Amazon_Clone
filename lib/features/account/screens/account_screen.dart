import 'package:amazon_clone/features/account/widgets/all_buttons.dart';
import 'package:amazon_clone/global_variables.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar_extension.dart';
import '../widgets/orders.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Container(
              child: Row(children: [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.notifications_outlined),
                ),
                Icon(Icons.search_outlined),
              ]),
            )
          ]),
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: Column(children: [
        AppBarExtension(),
        SizedBox(
          height: 10,
        ),
        AllButtonss(),
        const SizedBox(
          height: 20,
        ),
        Orders(),
      ]),
    );
  }
}
