import 'package:flutter/material.dart';

class CShopTextField extends StatelessWidget {
  const CShopTextField({
    this.controller,
    this.label,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
    super.key,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label, hintText: hintText),
    );
  }
}
