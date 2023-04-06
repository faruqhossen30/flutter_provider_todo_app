import 'package:flutter/widgets.dart';
import 'package:flutter_provider_todo_app/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TODOModel> _todoList = [];

  List<TODOModel> get allTodoList => _todoList;

  void addTodoList(TODOModel todoModel) {
    _todoList.add(todoModel);
    notifyListeners();
  }

  void removeTodoList(TODOModel todoModel) {
    final index = _todoList.indexOf(todoModel);
    _todoList.removeAt(index);
    notifyListeners();
  }

  void todoStatusChange(TODOModel todoModel) {
    final index = _todoList.indexOf(todoModel);
    _todoList[index].toggleCompleted();
    notifyListeners();
  }


}
