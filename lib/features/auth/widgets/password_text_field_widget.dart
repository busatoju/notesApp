import 'package:flutter/material.dart';

class PasswrodTextFieldWidget extends StatelessWidget {
  const PasswrodTextFieldWidget({
    Key? key,
    required this.controller,
    required this.showPassword,
    required this.isObscure,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback showPassword;
  final bool isObscure;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: isObscure,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        hintText: 'Senha',
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.teal,
        ),
        errorStyle: const TextStyle(fontSize: 16),
        suffixIcon: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: showPassword,
            child: Icon(isObscure ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey.shade600)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
      ),
    );
  }
}
