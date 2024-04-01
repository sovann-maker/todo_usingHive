import 'package:flutter/material.dart';
import 'package:todo/theme/theme.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSaved;
  final VoidCallback onCancel;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.yellow[300],
      actions: [
        Container(
          height: 160,
          width: 300,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    hintText: 'Add a new task',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).brightness == lightMode
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: onSaved,
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Theme.of(context).brightness == lightMode
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).brightness == lightMode
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: onCancel,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).brightness == lightMode
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
