import 'package:amazon_clone/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarExtension extends StatelessWidget {
  const AppBarExtension({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: 'Hello, ',
                children: [
                  TextSpan(
                      text: user.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600))
                ],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                )),
          ),
        ],
      ),
    );
  }
}
