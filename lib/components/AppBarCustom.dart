import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget AppBarCustom(BuildContext context, String active) {
  final brightness = MediaQuery.of(context).platformBrightness;

  return AppBar(
    toolbarHeight: 60,
    backgroundColor: Theme.of(context).colorScheme.background,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness:
            brightness == Brightness.dark ? Brightness.light : Brightness.dark,
        statusBarColor: Theme.of(context).colorScheme.background),
    actions: [
      Expanded(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(
            onPressed: () {
              context.goNamed('Notes');
            },
            child: Text(
              "Notes",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: active == "Notes"
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSecondary),
            )),
        TextButton(
            onPressed: () {
              context.goNamed('Todo');
            },
            child: Text(
              "Tasks",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: active == "Todos"
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSecondary),
            )),
      ]))
    ],
  );
}
