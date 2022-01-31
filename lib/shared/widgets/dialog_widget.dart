import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    Key? key,
    required this.title,
    required this.yes,
    required this.no,
  }) : super(key: key);
  
  final String title;
  final VoidCallback yes;
  final VoidCallback no;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        TextButton(onPressed: no, child: const Text('Não')),
        TextButton(
          onPressed: yes,
          child: const Text('Sim'),
          style: TextButton.styleFrom(
              backgroundColor: Colors.teal, primary: Colors.white),
        ),
      ],
    );
  }
}
