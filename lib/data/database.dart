import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List todoList = [];

  // reference the box
  final _myBox = Hive.box('mybox');

  void createInitialData() {
    todoList = [
      ['Make Tutorial', false],
      ['Do Exercise', false],
    ];
  }

  void loadData() {
    todoList = _myBox.get('TODOLIST');
  }

  void updateDataBase() {
    _myBox.put('TODOLIST', todoList);
  }
}
