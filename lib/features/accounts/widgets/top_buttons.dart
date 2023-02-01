// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/features/accounts/services/account_services.dart';
import 'package:amazon_clone/features/accounts/widgets/account_button.dart';
import "package:flutter/material.dart";

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final accountServices = AccountServices();
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
                accountServices.logOut(context);
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
