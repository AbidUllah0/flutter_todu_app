import 'package:flutter/material.dart';
import 'package:flutter_todu_app/model/todo_model.dart';
import 'package:flutter_todu_app/presentation/home_screen/components/todo_card_widget.dart';
import 'package:flutter_todu_app/presentation/new_task_page/new_task_page.dart';
import 'package:flutter_todu_app/utils/data.dart';
import 'package:flutter_todu_app/widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void addTodo(TodoModel todoModel) {
    listOfTodo.add(todoModel);
    if (category == "All List" || category == "Pending") {
      _tempListOfTodo.add(todoModel);
    }
    setState(() {});
  }

  String category = "Pending";

  updateStatus(String id, bool status) async {
    int index = listOfTodo.indexWhere((element) => element.id == id);
    listOfTodo[index].status = status;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 500));
    if (category == 'All List') {
      _tempListOfTodo = listOfTodo;
    } else if (category == 'Pending') {
      _tempListOfTodo =
          listOfTodo.where((element) => element.status == false).toList();
    } else if (category == 'Finished') {
      _tempListOfTodo =
          listOfTodo.where((element) => element.status == true).toList();
    } else {
      ///set all the remaining
      _tempListOfTodo =
          listOfTodo.where((element) => element.type == category).toList();
    }
    setState(() {});
  }

  List<TodoModel> listOfTodo = [];
  List<TodoModel> _tempListOfTodo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'TODO : $category',
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              category = value!;
              if (category == 'All List') {
                _tempListOfTodo = listOfTodo;
              } else if (category == 'Pending') {
                _tempListOfTodo = listOfTodo
                    .where((element) => element.status == false)
                    .toList();
              } else if (category == 'Finished') {
                _tempListOfTodo = listOfTodo
                    .where((element) => element.status == true)
                    .toList();
              } else {
                ///set all the remaining
                _tempListOfTodo = listOfTodo
                    .where((element) => element.type == value)
                    .toList();
              }
              setState(() {});
            },
            itemBuilder: (context) {
              return popUpMenuItemList.map(
                (e) {
                  return PopupMenuItem(
                    value: e,
                    child: CustomText(
                      text: e,
                    ),
                  );
                },
              ).toList();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTaskPage(
                ///this is the function which will be received by the new task page class
                addTodo: addTodo,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: _tempListOfTodo.map((e) {
          return TodoCardWidget(
            todoModel: e,
            update: updateStatus,
          );
        }).toList(),
      ),
    );
  }
}
