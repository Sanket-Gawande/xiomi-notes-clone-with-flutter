import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mi_notes/provider/notes.provider.dart';
import 'package:provider/provider.dart';

class NoteDetails extends StatefulWidget {
  final String? index;
  NoteDetails({super.key, this.index});

  @override
  State<NoteDetails> createState() => _NoteDetailsState(this.index);
}

class _NoteDetailsState extends State<NoteDetails> {
  String? _index;
  int? index;
  Box notesBox = Hive.box('notes_box');
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _NoteDetailsState(this._index) {
    index = _index == "add_new_note" ? null : int.parse(_index!);
    print('re-init');
    List notes = notesBox.get('notes') ?? [];
    print("reading notes");
    if (index != null) {
      print("assigning to controllers");
      titleController.text = notes[index!]["title"];
      descriptionController.text = notes[index!]["desc"];
    }
    print("assigned");
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: true);

    void handleSave() {
      if (titleController.text.isEmpty && descriptionController.text.isEmpty) {
        return;
      }
      if (index == null) {
        notesProvider.addNote(titleController.text, descriptionController.text);
      } else {
        notesProvider.updateNote(
            index!, titleController.text, descriptionController.text);
      }
      print("note saved successfully!");
      SnackBar snackBar = SnackBar(
        content: Text(
          'Note saved successfully!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void handleDelete() {
      if (index == null) {
        return;
      }

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                surfaceTintColor: Theme.of(context).colorScheme.secondary,
                contentPadding: EdgeInsets.all(12),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                title: Text(
                  "Are you sure to delete?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        notesProvider.deleteNote(index!);
                        context.goNamed("Notes");
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                  TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onTertiary,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)))
                ],
              ));
    }

    final brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
              statusBarColor: Theme.of(context).colorScheme.background),
          forceMaterialTransparency: true,
          toolbarHeight: 50,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
                onPressed: handleSave,
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 18),
                )),
            IconButton(
                color: Colors.red,
                onPressed: handleDelete,
                icon: Icon(
                  Icons.delete,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: titleController,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    border: InputBorder.none),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Row(
                children: [
                  Text(
                    DateFormat.yMMMEd().format(DateTime.now()),
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onTertiary),
                  ),
                  Text(
                    " | ",
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onTertiary),
                  ),
                  Text(
                    descriptionController.text.length.toString() +
                        ' characters',
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onTertiary),
                  )
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                  controller: descriptionController,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write something...",
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontWeight: FontWeight.w400))),
            ))
          ],
        ));
  }
}
