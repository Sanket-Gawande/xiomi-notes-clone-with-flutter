import 'package:flutter/material.dart';
import 'package:mi_notes/components/AppBarCustom.dart';
import 'package:mi_notes/components/create-todo-modal.dart';
import 'package:mi_notes/components/todo-tile.dart';
import 'package:mi_notes/models/todo.dart';
import 'package:mi_notes/provider/todo.provider.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    void onSubmit(String todo, DateTime? deadline) {
      if (todo.isNotEmpty) {
        setState(() {
          Provider.of<TodoProvider>(context, listen: false)
              .addTodo(Todo(title: todo, deadline: deadline));
        });
      }
      Navigator.pop(context);
    }

    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBarCustom(context, "Todos"),
      floatingActionButton: Builder(builder: (context) {
        return GestureDetector(
          onTap: () => handleCreate(context, onSubmit),
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
      body: todoProvider.todos.length > 0
          ? Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                    //           style: TextStyle(color: Colors.grey, fontSize: 18),
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
                    )),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: todoProvider.todos.length,
                    itemBuilder: (context, index) {
                      return TodoTile(
                          todo: Todo(
                              title: todoProvider.todos[index]['title'],
                              deadline: todoProvider.todos[index]['deadline'],
                              createdAt: todoProvider.todos[index]['createdAt'],
                              completed: todoProvider.todos[index]
                                  ['completed']),
                          delete: () => todoProvider.deleteTodo(index),
                          update: (bool? completed) {
                            todoProvider.updateTodo(completed!, index);
                          });
                    },
                  ),
                ))
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No tasks here yet!',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onTertiary),
                  )
                ],
              ),
            ),
    );
  }
}
