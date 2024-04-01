import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final void Function(bool?) onChanged;
  final void Function(BuildContext)? deleteFunction;

  const TodoList({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Theme.of(context).primaryColor,
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                // color: Colors.yellow,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Theme(
                      data: ThemeData(
                          unselectedWidgetColor:
                              Theme.of(context).primaryColor),
                      child: Checkbox(
                        value: taskCompleted,
                        onChanged: onChanged,
                        activeColor: Theme.of(context).primaryColor,
                        checkColor: Colors.red,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    // Icon(Icons.check_box),
                    const SizedBox(width: 10),
                    Text(
                      taskName,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
