import 'package:flutter/material.dart';
import 'package:note_app/features/edit_note/edit_note_viewmodel.dart';
import '../create_note/widget/create_note_widget.dart';

class EditNotePage extends StatelessWidget {
  const EditNotePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = EditNoteViewModel(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição'),
        leading: BackButton(
          onPressed: () => _viewModel.dialogEdit,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _viewModel.formKey,
          child: CreateNoteWidget(
            titleController: _viewModel.titleController,
            bodyController: _viewModel.bodyController,
            titleValidator: _viewModel.validator.validateTitle,
            bodyValidator: _viewModel.validator.validateBody,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _viewModel.editNote(),
        label: const Text(
          'Salvar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
