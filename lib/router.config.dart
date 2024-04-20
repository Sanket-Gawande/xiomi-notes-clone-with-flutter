import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_notes/pages/note_details.dart';
import 'package:mi_notes/pages/notes.dart';
import 'package:mi_notes/pages/todo.dart';

class AppRouter {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      name: "Notes",
      pageBuilder: (context, state) => MaterialPage(child: NotesPage()),
    ),
    GoRoute(
      path: '/todo',
      name: "Todo",
      pageBuilder: (context, state) => MaterialPage(child: TodoPage()),
    ),
    GoRoute(
      path: '/note_details/:index',
      name: "Note Details",
      pageBuilder: (context, state) => MaterialPage(
          child: NoteDetails(index: state.pathParameters["index"])),
    ),
  ]);
}
