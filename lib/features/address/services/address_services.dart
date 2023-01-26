import 'dart:convert';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      var response = await http.post(
        Uri.parse("$uri/api/save-user-address"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode(
          {
            "address": address,
          },
        ),
      );

      ErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(response.body)["address"],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }

  void placeOrder(
    BuildContext context,
    String address,
    double totalPrice,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      var response = await http.post(Uri.parse("$uri/api/order"),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": userProvider.user.token,
          },
          body: jsonEncode(
            {
              "cart": userProvider.user.cart,
              "address": address,
              "totalPrice": totalPrice,
            },
          ));
      ErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
              context: context, message: "Your order has been placed!");
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }

  Future<void> deleteProduct(
      BuildContext context, String id, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      var response = await http.post(
        Uri.parse("$uri/admin/delete-product"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({"id": id}),
      );
      ErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
            context: context,
            message: "Product deleted successfeully",
          );
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }
}
