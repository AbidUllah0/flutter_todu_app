import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todu_app/model/todo_model.dart';
import 'package:flutter_todu_app/widgets/custom_text.dart';

class NewTaskPage extends StatefulWidget {
  Function(TodoModel) addTodo;

  NewTaskPage({required this.addTodo});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String dropDownValue = 'Work';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: CustomText(text: 'New Task'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.addTodo(
            TodoModel(
              id: DateTime.now().toString(),
              taskName: taskController.text,
              dueDate: dateController.text,
              type: dropDownValue,
              status: false,
            ),
          );
          Navigator.pop(context);
        },
        child: Icon(Icons.check),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'What is to be done?',
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
            TextFormField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: 'Enter your task',
              ),
            ),
            SizedBox(height: 50),
            CustomText(
              text: 'Due Date',
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      hintText: 'Date not set',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    dateController.text = date.toString().substring(0, 10);
                    print(date);
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
            SizedBox(height: 50),
            CustomText(
              text: 'Add to list',
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
            DropdownButton(
              isExpanded: true,
              value: dropDownValue,
              items: [
                DropdownMenuItem(
                  value: 'Work',
                  child: CustomText(text: 'Work'),
                ),
                DropdownMenuItem(
                  value: 'Personal',
                  child: CustomText(text: 'Personal'),
                ),
                DropdownMenuItem(
                  child: CustomText(text: 'Shopping'),
                  value: 'Shopping',
                ),
                DropdownMenuItem(
                  child: CustomText(text: 'Wishlist'),
                  value: 'Wishlist',
                ),
              ],
              onChanged: (value) {
                dropDownValue = value!;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
