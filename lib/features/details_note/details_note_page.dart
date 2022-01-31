import 'package:flutter/material.dart';
import 'package:note_app/features/details_note/widget/body_details_widget.dart';
import 'package:note_app/features/edit_note/edit_note_viewmodel.dart';

class DetailsNotePage extends StatelessWidget {
  const DetailsNotePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = EditNoteViewModel(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _viewModel.navigatorEditNote(),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => _viewModel.deleteNote(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: BodyDetailsWidget(note: _viewModel.note!),
      ),
    );
  }
}
