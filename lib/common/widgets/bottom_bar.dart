import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:badges/badges.dart';
import "package:flutter/material.dart";

class BottomBar extends StatefulWidget {
  static const routeName = "/real-home";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _page = 0;
  double bottomBarWidht = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const Center(
      child: Text("Profile Page"),
    ),
    const Center(
      child: Text("Accounts"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
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
                    Icons.person_outline_outlined,
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
                    Icons.shopping_cart_outlined,
                  ),
                ),
              ],
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
