import 'package:mockito/mockito.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/db/dao/user_dao.dart';

class MockUsersCompanion extends Mock implements UsersCompanion {}

class MockUserDao extends Mock implements UserDao {}
