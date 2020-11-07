import 'package:flutter/material.dart';

class TodoNotifier extends ChangeNotifier {
  List<Todo> currentTodos = todos;

  void addTodo(Todo todo) {
    currentTodos.add(todo);
    notifyListeners();
  }

  void updateTodoDone(Todo todo) {
    final index = currentTodos.indexOf(todo);
    final isDone = currentTodos.elementAt(index).isDone;
    currentTodos.elementAt(index).isDone = !isDone;
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    final index = currentTodos.indexOf(todo);
    currentTodos.removeAt(index);
    notifyListeners();
  }

  void updateTodoTask(String updatedTask, {Todo todo}) {
    final index = currentTodos.indexOf(todo);
    currentTodos.elementAt(index).task = updatedTask;
    notifyListeners();
  }
}

class Todo {
  String task;
  bool isDone;

  Todo({this.task, this.isDone = false});
}

final todos = [
  Todo(task: 'Finish all 10 apps'),
  Todo(task: 'Exercise'),
];
