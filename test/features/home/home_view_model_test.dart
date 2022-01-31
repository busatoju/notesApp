import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/features/create_note/create_note_page.dart';
import 'package:note_app/features/details_note/details_note_page.dart';
import 'package:note_app/features/home/home_view_model.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/db/dao/note_dao.dart';
import 'package:note_app/shared/db/dao/user_dao.dart';
import 'package:note_app/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../matchers/matchers.dart';

void main() {
  late final HomeViewModel viewModel;
  late final UserDao userDao;
  late final UserProvider userProvider;
  late final NoteDao noteDao;
  late Widget pump;

  setUp(() {
    pump = pumpProvider(Builder(builder: (context) {
      viewModel = HomeViewModel(context);
      userDao = Provider.of<AppDatabase>(context, listen: false).userDao;
      noteDao = Provider.of<AppDatabase>(context, listen: false).noteDao;
      userProvider = Provider.of<UserProvider>(context);

      return Container();
    }));
  });

  testWidgets('Deve verificar se as notas estão sendo listada', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(pump);

      final id = await userDao.createAccount(UsersCompanion.insert(
          username: 'Juliana', password: 'teste123', email: 'email@email.com'));
      final User? user = await userDao.getUser(id);
      userProvider.setUser = user!;

      await noteDao.insertNote(
          note: NotesCompanion.insert(
              userId: id,
              title: 'Teste',
              body: 'Teste',
              username: DateTime.now()),
          userId: id);

      final Stream<List<Note>> stream = viewModel.fetchListNote();

      final List<Note> listStream = await stream.first;

      expect(listStream[0].title, 'Teste');
    });
  });

  testWidgets('Deve verificar se direciona para Details Page', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(pump);

      final id = await userDao.createAccount(UsersCompanion.insert(
          username: 'Juliana', password: 'teste123', email: 'email@email.com'));
      final User? user = await userDao.getUser(id);
      userProvider.setUser = user!;

      await noteDao.insertNote(
          note: NotesCompanion.insert(
              userId: id,
              title: 'Teste',
              body: 'Teste',
              username: DateTime.now()),
          userId: id);

      final Stream<List<Note>> stream = viewModel.fetchListNote();

      final List<Note> listStream = await stream.first;

      viewModel.navigatorDetailsPage(listStream.first);

      await tester.pumpAndSettle();

      final details = find.byType(DetailsNotePage);

      expect(details, findsOneWidget);
    });
  });

  testWidgets('Deve verificar se direciona para CreateNote', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(pump);

      final id = await userDao.createAccount(UsersCompanion.insert(
          username: 'Juliana', password: 'teste123', email: 'email@email.com'));
      final User? user = await userDao.getUser(id);
      userProvider.setUser = user!;

      viewModel.navigatorCreateNote();

      await tester.pumpAndSettle();

      final details = find.byType(CreateNotePage);

      expect(details, findsOneWidget);
    });
  });
}
