import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/accounts/widgets/below_app_bar.dart';
import 'package:amazon_clone/features/accounts/widgets/orders.dart';
import 'package:amazon_clone/features/accounts/widgets/top_buttons.dart';
import "package:flutter/material.dart";

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/amazon_in.png",
                width: 120,
                height: 45,
              ),
              const Spacer(),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.notifications_outlined),
                  ),
                  Icon(Icons.search),
                ],
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            BelowAppBar(),
            SizedBox(
              height: 10,
            ),
            TopButtons(),
            SizedBox(
              height: 20,
            ),
            Orders(),
          ],
        ),
      ),
    );
  }
}
