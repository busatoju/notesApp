import 'package:flutter/cupertino.dart';
import 'package:note_app/shared/db/app_database.dart';

class NoteProvider extends ChangeNotifier {
  Note? _note;

  set setNote(Note note) {
    _note = note;
    notifyListeners();
  }

  Note? get note => _note;
}
