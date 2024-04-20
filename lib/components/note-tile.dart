import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mi_notes/models/note.dart';

class NoteTile extends StatelessWidget {
  final int index;
  final Note note;
  NoteTile({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    String title = (note.title ?? '').trim().length > 0
        ? note.title!
        : note.desc!.split('\n')[0];
    List<String>? temp = note.desc?.split('\n');
    temp?.removeAt(0);
    
    String desc =
        (note.title ?? '').trim().length == 0 ? temp!.join('\n') : note.desc!;
    return GestureDetector(
      onTap: () {
        context.push('/note_details/$index');
      },
      child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.secondary),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                desc.trim().length > 0 ? desc : 'No text',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                DateFormat('dd MMMM, yyyy - hh:mm a').format(note.createdAt),
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
            ],
          )),
    );
  }
}
