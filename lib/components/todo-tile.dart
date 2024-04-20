import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mi_notes/models/todo.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime inputDate) {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('dd MMMM, yyyy hh:mm a');

  if (inputDate.year == now.year &&
      inputDate.month == now.month &&
      inputDate.day == now.day) {
    return DateFormat('hh:mm a').format(inputDate);
  } else if (inputDate.isAfter(now)) {
    return formatter.format(inputDate);
  } else {
    return formatter.format(inputDate);
  }
}

class TodoTile extends StatelessWidget {
  final Todo todo;

  final Function() delete;
  final void Function(bool? completed)? update;
  TodoTile(
      {super.key,
      required this.todo,
      required this.delete,
      required this.update});
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16)),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: .16,
          children: [
            SlidableAction(
              onPressed: (_) => delete(),
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(50),
              padding: EdgeInsets.all(6),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.25,
              child: Checkbox(
                value: todo.completed,
                onChanged: update,
                hoverColor: Colors.amber,
                side: BorderSide(
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title!,
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      decorationColor: Theme.of(context).colorScheme.primary,
                      decoration: todo.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  todo.deadline == null
                      ? DateFormat('dd MMMM, yyyy').format(todo
                          .createdAt!) // ? todo.createdAt.toString().substring(0, 16)
                      : "Deadline - " + formatDate(todo.deadline!),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: todo.deadline == null
                          ? Theme.of(context).colorScheme.onTertiary
                          : todo.deadline != null && todo.completed
                              ? Colors.green
                              : Colors.orange),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
