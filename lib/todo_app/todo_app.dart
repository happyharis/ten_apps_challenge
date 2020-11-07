import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ten_apps_challenge/todo_app/todo_notifier.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoNotifier = Provider.of<TodoNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Column(
        children: [
          for (var todo in todoNotifier.currentTodos)
            CheckboxListTile(
              secondary: PopupMenuButton<Action>(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: Action.edit,
                      child: Text('Edit'),
                    ),
                    PopupMenuItem(
                      value: Action.delete,
                      child: Text('Delete'),
                    ),
                  ];
                },
                onSelected: (value) {
                  final todoController = TextEditingController(text: todo.task);
                  switch (value) {
                    case Action.delete:
                      todoNotifier.deleteTodo(todo);
                      break;
                    case Action.edit:
                      showDialog(
                        context: context,
                        child: SimpleDialog(
                          contentPadding: EdgeInsets.all(18),
                          children: [
                            Text('Update Todo',
                                style: Theme.of(context).textTheme.headline5),
                            TextField(
                              controller: todoController,
                              decoration:
                                  InputDecoration(hintText: 'Do 10 push ups'),
                            ),
                            OutlinedButton(
                              child: Text('Update'),
                              onPressed: () {
                                todoNotifier.updateTodoTask(todoController.text,
                                    todo: todo);
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      );
                      break;
                    default:
                  }
                },
              ),
              title: Text(
                todo.task,
                style: TextStyle(
                    decoration: todo.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              onChanged: (value) {
                todoNotifier.updateTodoDone(todo);
              },
              value: todo.isDone,
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final todoController = TextEditingController();
          showDialog(
            context: context,
            child: SimpleDialog(
              contentPadding: EdgeInsets.all(18),
              children: [
                Text('Add Todo', style: Theme.of(context).textTheme.headline5),
                TextField(
                  controller: todoController,
                  decoration: InputDecoration(hintText: 'Do 10 push ups'),
                ),
                OutlinedButton(
                  child: Text('Add'),
                  onPressed: () {
                    todoNotifier.addTodo(Todo(task: todoController.text));
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        },
        child: Icon(Icons.edit_outlined),
      ),
    );
  }
}

enum Action { delete, edit }
