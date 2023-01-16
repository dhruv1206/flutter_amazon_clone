import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void ErrorHandling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  if (response.statusCode == 200) {
    onSuccess();
  } else if (response.statusCode == 400) {
    showSnackBar(context: context, message: jsonDecode(response.body)["msg"]);
  } else if (response.statusCode == 500) {
    showSnackBar(context: context, message: jsonDecode(response.body)["error"]);
  } else {
    showSnackBar(context: context, message: response.body);
  }
}
