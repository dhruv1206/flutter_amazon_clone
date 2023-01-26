// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/features/accounts/widgets/account_button.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

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
              onPress: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.clear();
                Navigator.pushNamed(
                  context,
                  AuthScreen.routeName,
                );
              },
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
