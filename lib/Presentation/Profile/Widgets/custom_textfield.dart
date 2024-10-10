import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hint;
  final String label;
  final TextInputType? keyboardType;
  final Color color;
  final Widget? suffixIcon;
  final void Function(String)? onChanged; // Update the signature of onTap

  const CustomTextField(
      {Key? key,
      required this.obscureText,
      required this.hint,
      required this.label,
      required this.controller,
      required this.validator,
      required this.keyboardType,
      required this.color,
      required this.onChanged,
      required this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autocorrect: true,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: color,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
