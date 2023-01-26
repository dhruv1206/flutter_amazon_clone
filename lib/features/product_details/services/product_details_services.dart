import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/products.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../models/user.dart';

class ProductDetailsServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      var res = await http.post(
        Uri.parse("$uri/api/add-to-cart"),
        headers: <String, String>{
          "Content-type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode(
          {
            "id": product.id,
          },
        ),
      );

      ErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)["cart"]);
            userProvider.setUserFromModel(user);
            showSnackBar(
                context: context, message: "Product added to your cart");
          });
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      var res = await http.post(
        Uri.parse("$uri/api/rate-product"),
        headers: <String, String>{
          "Content-type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode(
          {
            "id": product.id,
            "rating": rating,
          },
        ),
      );

      ErrorHandling(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }
}
