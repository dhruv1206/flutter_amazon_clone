// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/global_variables.dart';

class AuthService {
  void signup({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
        cart: [],
      );

      var response = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      ErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
              context: context,
              message: "Account created! Login with the same credentials.");
        },
      );

      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      if (kDebugMode) {
        showSnackBar(context: context, message: e.toString());
      }
    }
  }

  void signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String? token = pref.getString("x-auth-token");

      if (token == null) {
        pref.setString('x-auth-token', '');
      }

      final tokenRes = await http.post(
        Uri.parse("$uri/tokenIsValid"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        var userResponse = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      // showSnackBar(context: context, message: e.toString());
    }
  }
}
