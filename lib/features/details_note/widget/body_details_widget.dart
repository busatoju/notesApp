import 'package:flutter/material.dart';
import 'package:note_app/shared/db/app_database.dart';

class BodyDetailsWidget extends StatelessWidget {
  const BodyDetailsWidget({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              note.body,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        );
  }
}
