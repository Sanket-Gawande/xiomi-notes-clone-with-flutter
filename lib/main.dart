import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mi_notes/models/note.dart';
import 'package:mi_notes/models/todo.dart';
import 'package:mi_notes/provider/notes.provider.dart';
import 'package:mi_notes/provider/theme.provider.dart';
import 'package:mi_notes/provider/todo.provider.dart';
import 'package:mi_notes/router.config.dart';
import 'package:mi_notes/theme/config.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  // opening tasks box
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox('tasks_box');

  // opening notes box
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox('notes_box');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => NotesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
    ),
  ], child: const NotesApp()));
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  // Map<String, Widget> pages = {
  //   ROUTES.notes.name: NotesPage(),
  //   ROUTES.todo.name:  TodoPage()
  // };
  // String page = ROUTES.notes.name;

  // void goto(ROUTES route) {
  //   setState(() {
  //     page = route.name;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: Provider.of<ThemeProvider>(context).theme,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      
    );
  }
}
