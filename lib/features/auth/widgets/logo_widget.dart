import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      child: Icon(
        Icons.edit,
        size: size,
      ),
    );
  }
}
