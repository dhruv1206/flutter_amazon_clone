import 'package:amazon_clone/features/accounts/widgets/account_button.dart';
import "package:flutter/material.dart";

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "Your Orders",
              onPress: () {},
            ),
            AccountButton(
              text: "Turn Seller",
              onPress: () {},
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
              onPress: () {},
            ),
            AccountButton(
              text: "Your Wishlist",
              onPress: () {},
            ),
          ],
        ),
      ],
    );
  }
}
