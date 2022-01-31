import 'package:moor_flutter/moor_flutter.dart';
import 'dao/note_dao.dart';
import 'dao/user_dao.dart';
part 'app_database.g.dart';

class Users extends Table {
  TextColumn get username => text()();
  TextColumn get password => text().withLength(min: 6)();
  TextColumn get email => text()();
  IntColumn get id => integer().autoIncrement()();
}

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  DateTimeColumn get username => dateTime()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}

@UseMoor(tables: [Users, Notes], daos: [UserDao, NoteDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? e})
      : super(e = e ??
            FlutterQueryExecutor.inDatabaseFolder(
                path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}
