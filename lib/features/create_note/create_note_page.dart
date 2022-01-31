import 'package:flutter/material.dart';
import 'create_note_viewmodel.dart';
import 'widget/create_note_widget.dart';

class CreateNotePage extends StatelessWidget {
  CreateNotePage({
    Key? key,
  }) : super(key: key);

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _viewModel = CreateNoteViewmodel(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _viewModel.formKey,
          child: CreateNoteWidget(
            titleController: titleController,
            bodyController: bodyController,
            bodyValidator: _viewModel.validateBody,
            titleValidator: _viewModel.validateTitle,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            _viewModel.insertNote(titleController.text, bodyController.text),
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
