import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../shared/db/dao/note_dao.dart';

class CreateNoteViewmodel {
  final BuildContext context;
  late final NoteDao _db;
  final _formKey = GlobalKey<FormState>();
  late final UserProvider _userProvider;

  CreateNoteViewmodel(this.context) {
    _db = Provider.of<AppDatabase>(context).noteDao;
    _userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  GlobalKey<FormState> get formKey => _formKey;

  String? validateTitle(String? title) =>
      title!.isNotEmpty ? null : 'Informe o título';

  String? validateBody(String? body) =>
      body!.isNotEmpty ? null : 'Preencha o campo';

  void insertNote(String title, String body) {
    if (_formKey.currentState!.validate()) {
      _db.insertNote(
          note: NotesCompanion(
              title: Value(title),
              body: Value(body),
              userId: Value(_userProvider.user!.id),
              username: Value(DateTime.now())),
          userId: _userProvider.user!.id);

      Navigator.pop(context);
    }
  }
}
