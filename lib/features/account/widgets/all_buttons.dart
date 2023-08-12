import 'package:flutter/material.dart';

import 'account_button.dart';

class AllButtonss extends StatelessWidget {
  const AllButtonss({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "Your Orders",
              onTap: () {},
            ),
            AccountButton(
              text: "Turn Seller",
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: "Log Out",
              onTap: () {},
            ),
            AccountButton(
              text: "Your Wish List",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
