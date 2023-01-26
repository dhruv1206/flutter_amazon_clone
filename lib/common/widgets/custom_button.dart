// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";

import 'package:amazon_clone/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  VoidCallback onTap;
  final Color? color;
  CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        minimumSize: const Size(
          double.infinity,
          50,
        ),
        backgroundColor: color ?? GlobalVariables.secondaryColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
