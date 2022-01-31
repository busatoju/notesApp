import 'package:moor_flutter/moor_flutter.dart';
import 'package:note_app/shared/db/app_database.dart';
part 'note_dao.g.dart';

@UseDao(tables: [Notes, Users])
class NoteDao extends DatabaseAccessor<AppDatabase> with _$NoteDaoMixin {
  NoteDao(AppDatabase db) : super(db);

  Future<int> insertNote(
      {required NotesCompanion note, required int userId}) async {
    return await into(notes).insert(note);
  }

  Future<int> deleteNote(int id) {
    var query = delete(notes)..where((note) => note.id.equals(id));
    return query.go();
  }

  Future<bool> updateNote(Note note) => update(notes).replace(note);

  Stream<List<Note>> getNote(int? userId) {
    var query = select(notes)..where((note) => note.userId.equals(userId));
    return query.watch();
  }

  Future<List<Note>> futureNote(int userId) {
    var query = select(notes)..where((note) => note.userId.equals(userId));
    return query.get();
  }
}
