import 'package:flutter/material.dart';

class TitleTextFieldWidget extends StatelessWidget {
  const TitleTextFieldWidget({
    Key? key,
    required this.titleController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController titleController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: titleController,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        errorStyle: TextStyle(fontSize: 16),
        hintText: 'Título',
        hintStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
