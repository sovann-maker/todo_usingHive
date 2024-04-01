import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/pages/todoList.dart';
import 'package:todo/theme/theme.dart';
import 'package:todo/theme/theme_provider.dart';
import 'package:todo/utils/dialogBox.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');

  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createDialogue() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: _controller,
        onCancel: () {
          Navigator.of(context).pop();
        },
        onSaved: saveNewTask,
      ),
    );
  }

  void removeTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = -1;

    return Scaffold(
      // backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('Sovann\'s TO-DO List'),
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu)),
        ),
        // backgroundColor: Colors.yellow,
      ),
      drawer: Drawer(
        child: DrawerHeader(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Appearance',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode_rounded),
                title: const Text('Dark theme'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleDarkTheme();
                },
              ),
              ListTile(
                leading: const Icon(Icons.light_mode_rounded),
                title: const Text('Light theme'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleLightTheme();
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).brightness == lightMode
            ? Colors.black
            : Colors.white,
        onPressed: createDialogue,
        child: Icon(
          Icons.add,
          color: Theme.of(context).brightness == lightMode
              ? Colors.white
              : Colors.black,
        ),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) => TodoList(
          taskName: db.todoList[index][0],
          taskCompleted: db.todoList[index][1],
          onChanged: (value) => checkBoxChanged(value, index),
          deleteFunction: (context) => removeTask(index),
        ),
      ),
    );
  }
}
