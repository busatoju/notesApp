import 'package:flutter/material.dart';

class BodyTextFieldWidget extends StatelessWidget {
  const BodyTextFieldWidget({
    Key? key,
    required this.bodyController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController bodyController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: bodyController,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
      maxLines: null,
      decoration: const InputDecoration(
        errorStyle: TextStyle(fontSize: 16),
        border: InputBorder.none,
        hintText: 'Insira sua anotação aqui...',
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
