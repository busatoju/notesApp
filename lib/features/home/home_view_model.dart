import 'package:flutter/material.dart';
import 'package:note_app/features/auth/login_page.dart';
import 'package:note_app/features/create_note/create_note_page.dart';
import 'package:note_app/features/details_note/details_note_page.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/db/dao/note_dao.dart';
import 'package:note_app/shared/providers/note_provider.dart';
import 'package:note_app/shared/providers/user_provider.dart';
import 'package:note_app/shared/services/preferences_service.dart';
import 'package:note_app/shared/widgets/dialog_widget.dart';
import 'package:provider/provider.dart';

class HomeViewModel {
  late final NoteDao _db;
  late Stream<List<Note>> _streamListNote;
  late List<Note> _listNote;
  late final BuildContext context;
  late final UserProvider _userProvider;

  HomeViewModel(this.context) {
    _db = Provider.of<AppDatabase>(context, listen: false).noteDao;
    _userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  Stream<List<Note>> fetchListNote() {
    _streamListNote = _db.getNote(_userProvider.user?.id);
    return _streamListNote;
  }

  set setListNote(List<Note> list) => _listNote = list;

  List<Note> get listNote => _listNote;
  int get lenghtList => _listNote.length;

  void navigatorCreateNote() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateNotePage()));
  }

  void logoff() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogWidget(
              title: 'Deseja sair da conta?',
              yes: () {
                PrefsService.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => true);
              },
              no: () => Navigator.pop(context));
        });
  }

  void navigatorDetailsPage(Note note) {
    final _noteProvider = Provider.of<NoteProvider>(context, listen: false);
    _noteProvider.setNote = note;

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DetailsNotePage()));
  }
}
