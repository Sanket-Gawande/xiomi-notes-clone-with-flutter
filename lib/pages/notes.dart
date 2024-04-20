import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_notes/components/note-tile.dart';
import 'package:mi_notes/components/AppBarCustom.dart';
import 'package:mi_notes/models/note.dart';
import 'package:mi_notes/provider/notes.provider.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
        appBar: AppBarCustom(context, "Notes"),
        // appBar: AppbarCustom(),
        floatingActionButton: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => context.push('/note_details/add_new_note'),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          );
        }),
        body: noteProvider.notes.length > 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(50)),
                    // child: const Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Icon(Icons.search, color: Colors.grey),
                    //       Padding(
                    //         padding: EdgeInsets.only(left: 8.0),
                    //         child: Text(
                    //           "Search",
                    //           style:
                    //               TextStyle(color: Colors.grey, fontSize: 18),
                    //         ),
                    //       )
                    //     ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_sync, color: Colors.grey),
                        SizedBox(
                          width: 6,
                        ),
                        Text("Coming soon: Sync with cloud",
                            style: TextStyle(color: Colors.grey, fontSize: 16))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: ListView.builder(
                        itemCount: noteProvider.notes.length,
                        itemBuilder: (context, index) => NoteTile(
                          index: index,
                          note: Note(
                              title: noteProvider.notes[index]["title"],
                              desc: noteProvider.notes[index]["desc"],
                              UpdatedAt: noteProvider.notes[index]
                                  ["updatedAt"]),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/notes-2.png',
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Click + Button to add notes!',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onTertiary),
                  )
                ],
              )));
  }
}
