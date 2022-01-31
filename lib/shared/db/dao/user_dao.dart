import 'package:moor_flutter/moor_flutter.dart';
import 'package:note_app/shared/db/app_database.dart';
part 'user_dao.g.dart';

@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(AppDatabase db) : super(db);

  Future<int> createAccount(UsersCompanion user) async {
    return await into(users).insert(user);
  }

  Future<User?>? signIn(
      {required String email, required String password}) async {
    final query = (select(users)
      ..where((u) => u.email.equals(email) & u.password.equals(password))
      ..limit(1));

    return await query.getSingleOrNull();
  }

  Future<User?> getUser(int userId) async {
    final query = select(users)
      ..where((u) => u.id.equals(userId))
      ..limit(1);

    return await query.getSingleOrNull();
  }
}
