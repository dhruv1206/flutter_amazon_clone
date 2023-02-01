import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/products.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("ddntiiwli", "fsb4qrnt");
      List<String> imageUrls = [];

      for (var image in images) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: name),
        );
        imageUrls.add(response.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      var response = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: product.toJson(),
      );

      ErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context: context, message: "Product added successfully");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> poroductList = [];
    try {
      var response = await http.get(
        Uri.parse("$uri/admin/get-products"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
      );
      ErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            poroductList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
    return poroductList;
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

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> ordersList = [];
    try {
      var response = await http.get(
        Uri.parse("$uri/admin/get-orders"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
      );
      ErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            ordersList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
    return ordersList;
  }

  Future<void> changeOrderStatus(
    BuildContext context,
    int status,
    Order order,
    VoidCallback onSuccess,
  ) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      var response = await http.post(
        Uri.parse("$uri/admin/change-order-status"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({
          "id": order.id,
          "status": status,
        }),
      );
      ErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarnings = 0;
    try {
      var response = await http.get(
        Uri.parse("$uri/admin/analytics"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
      );
      // ignore: use_build_context_synchronously
      ErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          var res = jsonDecode(response.body);
          print(res);
          totalEarnings = res["totalEarnings"];
          sales = [
            Sales(
              "Mobiles",
              res["mobileEarnings"],
            ),
            Sales(
              "Essentials",
              res["essentialEarnings"],
            ),
            Sales(
              "Appliances",
              res["applianceEarnings"],
            ),
            Sales(
              "Books",
              res["bookEarnings"],
            ),
            Sales(
              "Fashion",
              res["fashionEarning"],
            ),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
    return {
      "sales": sales,
      "totalEarnings": totalEarnings,
    };
  }
}
