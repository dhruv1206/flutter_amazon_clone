import 'package:amazon_clone/features/admin/screens/posts_screen.dart';
import "package:flutter/material.dart";

import '../../../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  var _page = 0;
  double bottomBarWidht = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const PostsScreen(),
    const Center(
      child: Text("Analytics Page"),
    ),
    const Center(
      child: Text("Accounts"),
    ),
  ];

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
              const Text(
                "Admin",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          _page = value;
        }),
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: bottomBarBorderWidth,
                  width: _page == 0 ? 40 : 0,
                  decoration: BoxDecoration(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: bottomBarWidht,
                  child: const Icon(
                    Icons.home_outlined,
                  ),
                ),
              ],
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: bottomBarBorderWidth,
                  width: _page == 1 ? 40 : 0,
                  decoration: BoxDecoration(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: bottomBarWidht,
                  child: const Icon(
                    Icons.analytics_outlined,
                  ),
                ),
              ],
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: bottomBarBorderWidth,
                  width: _page == 2 ? 40 : 0,
                  decoration: BoxDecoration(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: bottomBarWidht,
                  child: const Icon(
                    Icons.all_inbox_outlined,
                  ),
                ),
              ],
            ),
            label: "",
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}
