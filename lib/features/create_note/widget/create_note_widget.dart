import 'package:flutter/material.dart';
import 'package:note_app/features/create_note/widget/body_text_field_widget.dart';

import 'title_text_field_widget.dart';

class CreateNoteWidget extends StatelessWidget {
  const CreateNoteWidget({
    Key? key,
    required this.titleController,
    required this.bodyController,
    required this.titleValidator,
    required this.bodyValidator,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController bodyController;
  final String? Function(String?)? titleValidator;
  final String? Function(String?)? bodyValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleTextFieldWidget(
          titleController: titleController,
          validator: titleValidator,
        ),
        Expanded(
          child: BodyTextFieldWidget(
            bodyController: bodyController,
            validator: bodyValidator,
          ),
        ),
      ],
    );
  }
}
