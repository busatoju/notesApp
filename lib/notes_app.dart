import 'package:flutter/material.dart';
import 'package:note_app/features/splash/splash_page.dart';
import 'package:note_app/shared/providers/note_provider.dart';
import 'package:note_app/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'shared/db/app_database.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(
            create: (context) => AppDatabase(),
          ),
          Provider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => NoteProvider()),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
            ),
            home: const SplashPage(),
          );
        });
  }
}
