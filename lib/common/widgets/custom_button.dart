// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";

class CustomButton extends StatelessWidget {
  final String text;
  VoidCallback onTap;
  CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50)),
    );
  }
}
