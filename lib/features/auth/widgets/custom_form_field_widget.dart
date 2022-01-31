import 'package:flutter/material.dart';

class CustomFormFieldWidget extends StatelessWidget {
  const CustomFormFieldWidget({
    Key? key,
    required this.controller,
    required this.hint,
    this.validator,
    required this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        errorStyle: const TextStyle(fontSize: 16),
        prefixIcon: Icon(
          icon,
          color: Colors.teal,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
      ),
    );
  }
}
