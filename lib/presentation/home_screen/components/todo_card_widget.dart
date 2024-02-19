import 'package:flutter/material.dart';
import 'package:flutter_todu_app/model/todo_model.dart';

import '../../../widgets/custom_text.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoModel todoModel;
  Function(String, bool) update;

  TodoCardWidget({required this.todoModel, required this.update});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: CustomText(
          text: todoModel.taskName,
        ),
        subtitle: CustomText(
          text: todoModel.dueDate,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
        trailing: CustomText(
          text: todoModel.type,
          color: todoTypeColor(todoModel.type),
          fontWeight: FontWeight.bold,
        ),
        leading: Checkbox(
          value: todoModel.status,
          onChanged: (bool? value) {
            update(todoModel.id, value!);
          },
        ),
      ),
    );
  }
}

Color todoTypeColor(String value) {
  switch (value) {
    case "Shopping":
      return Colors.amber;
    case 'Work':
      return Colors.blue;
    case 'Personal':
      return Colors.red;
    case 'Wishlist':
      return Colors.orange;
    default:
      return Colors.black;
  }
}
