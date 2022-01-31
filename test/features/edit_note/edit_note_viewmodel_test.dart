import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/features/edit_note/edit_note_page.dart';
import 'package:note_app/features/edit_note/edit_note_viewmodel.dart';
import 'package:note_app/features/home/home_view_model.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/db/dao/note_dao.dart';
import 'package:note_app/shared/db/dao/user_dao.dart';
import 'package:note_app/shared/providers/note_provider.dart';
import 'package:note_app/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../matchers/matchers.dart';

void main() {
  late final EditNoteViewModel viewModel;
  late UserProvider userProvider;
  late NoteProvider noteProvider;
  late Widget pump;
  late UserDao userDao;
  late NoteDao noteDao;
  late final HomeViewModel homeViewModel;

  setUp(() {
    pump = pumpProvider(Builder(builder: (context) {
      viewModel = EditNoteViewModel(context);
      noteDao = Provider.of<AppDatabase>(context, listen: false).noteDao;
      userDao = Provider.of<AppDatabase>(context, listen: false).userDao;
      userProvider = Provider.of<UserProvider>(context);
      homeViewModel = HomeViewModel(context);
      noteProvider = Provider.of<NoteProvider>(context);

      return Scaffold(
        body: Form(
          key: viewModel.formKey,
          child: Container(),
        ),
      );
    }));
  });

  testWidgets('edit note viewmodel ...', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(pump);
      final userId = await userDao.createAccount(UsersCompanion.insert(
          username: 'Teste', password: 'Teste123', email: 'email@teste.com'));

      userProvider.setUser = (await userDao.getUser(userId))!;

      await noteDao.insertNote(
          note: NotesCompanion.insert(
              userId: userId,
              title: 'Teste',
              body: 'Teste',
              username: DateTime.now()),
          userId: userId);

      final Stream<List<Note>> stream = homeViewModel.fetchListNote();

      final List<Note> listStream = await stream.first;
      noteProvider.setNote = listStream[0];
      viewModel.titleController.text = 'Teste1';
      viewModel.editNote();
      expect(noteProvider.note!.title, 'Teste1');
    });
  });

  testWidgets('Navigator Edit note', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(pump);
      final userId = await userDao.createAccount(UsersCompanion.insert(
          username: 'Teste', password: 'Teste123', email: 'email@teste.com'));

      userProvider.setUser = (await userDao.getUser(userId))!;

      await noteDao.insertNote(
          note: NotesCompanion.insert(
              userId: userId,
              title: 'Teste',
              body: 'Teste',
              username: DateTime.now()),
          userId: userId);

      viewModel.navigatorEditNote();
      await tester.pumpAndSettle();
      final editPage = find.byType(EditNotePage);

      expect(editPage, findsOneWidget);
    });
  });
}
