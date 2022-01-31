import 'package:flutter/material.dart';
import 'package:note_app/features/edit_note/edit_note_page.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/db/dao/note_dao.dart';
import 'package:note_app/shared/providers/note_provider.dart';
import 'package:note_app/shared/validators/validators.dart';
import 'package:note_app/shared/widgets/dialog_widget.dart';
import 'package:provider/provider.dart';

class EditNoteViewModel {
  final BuildContext context;
  late final NoteDao _db;
  late final NoteProvider _note;
  late TextEditingController titleController;
  late TextEditingController bodyController;
  final _formKey = GlobalKey<FormState>();
  final Validators _validators = Validators();

  EditNoteViewModel(this.context) {
    _db = Provider.of<AppDatabase>(context).noteDao;
    _note = Provider.of<NoteProvider>(context);
    titleController = TextEditingController(text: _note.note?.title);
    bodyController = TextEditingController(text: _note.note?.body);
  }

  GlobalKey<FormState> get formKey => _formKey;

  Validators get validator => _validators;

  void navigatorEditNote() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const EditNotePage()));
  }

  Note? get note => _note.note;

  void editNote() {
    if (_formKey.currentState!.validate()) {
      final update = Note(
          id: _note.note!.id,
          userId: _note.note!.userId,
          title: titleController.text,
          body: bodyController.text,
          username: _note.note!.username,
          isFavorite: _note.note!.isFavorite);
      _db.updateNote(update);
      _note.setNote = update;

      Navigator.pop(context);
    }
  }

  void dialogEdit() async {
    showDialog(
        context: context,
        builder: (context) {
          return DialogWidget(
              title: 'Deseja descartar anotação?',
              yes: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              no: () => Navigator.pop(context));
        });
  }

  void deleteNote() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogWidget(
              no: () => Navigator.pop(context),
              yes: () {
                _db.deleteNote(_note.note!.id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              title: 'Deseja realmente excluir?');
        });
  }
}
