import 'package:flutter/material.dart';

void handleCreate(BuildContext context,
    void Function(String todo, DateTime? deadline) onSubmit) {
  TimeOfDay? deadline = null;

  TextEditingController todo = TextEditingController();

  void pickDeadline() async {
    deadline = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        orientation: Orientation.portrait);
  }

  showAdaptiveDialog(
    useSafeArea: true,
    context: context,
    builder: (context) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Material(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.15,
                        child: Checkbox(
                          value: false,
                          onChanged: (_) {},
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: TextField(
                          controller: todo,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary),
                          decoration: InputDecoration(
                              hintText: "Write something...",
                              hintStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onTertiary),
                              border: InputBorder.none),
                          cursorColor: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(50)),
                        child: GestureDetector(
                          onTap: pickDeadline,
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                                size: 18,
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Set Deadline",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            final now = new DateTime.now();
                            DateTime? timeStamp = deadline == null
                                ? null
                                : new DateTime(now.year, now.month, now.day,
                                    deadline!.hour, deadline!.minute);
                            onSubmit(todo.text, timeStamp);
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(fontSize: 18),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
