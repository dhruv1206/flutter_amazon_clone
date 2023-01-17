import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
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
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      ErrorHandling(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          await prefs.setString(
              "x-auth-token", jsonDecode(response.body)["token"]);
          showSnackBar(context: context, message: "Logged In Successfully.");
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
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

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String? token = pref.getString("x-auth-token");

      token ??= ""; //if null then assign empty string

      final tokenRes = await http.post(
        Uri.parse("$uri/tokenIsValid"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token,
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
      showSnackBar(context: context, message: e.toString());
    }
  }
}
