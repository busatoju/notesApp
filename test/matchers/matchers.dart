import 'package:flutter/material.dart';
import 'package:moor/ffi.dart';
import 'package:note_app/features/auth/widgets/custom_button_widget.dart';
import 'package:note_app/features/auth/widgets/custom_text_button_widget.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/providers/note_provider.dart';
import 'package:note_app/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';

Widget pumpProvider(Widget child) {
  return MultiProvider(
    providers: [
      Provider(create: (context) => AppDatabase(e: VmDatabase.memory())),
      Provider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => NoteProvider()),
    ],
    child: MaterialApp(home: child),
  );
}

bool textField(Widget widget, String hintText) {
  if (widget is TextField) {
    return widget.decoration?.hintText == hintText;
  }
  return false;
}

bool textButton(Widget widget, String title) {
  if (widget is CustomTextButtonWidget) {
    return widget.title == title;
  }
  return false;
}

bool elevatedButton(Widget widget, String title) {
  if (widget is CustomButtonWidget) {
    return widget.title == title;
  }
  return false;
}
