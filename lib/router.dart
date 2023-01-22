import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case CategoryDealsScreen.routeName:
      String category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => CategoryDealsScreen(
          category: category,
        ),
      );
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (context) => BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => AddProductScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Page Not Found!"),
          ),
        ),
      );
  }
}
