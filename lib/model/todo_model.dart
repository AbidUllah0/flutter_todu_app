import 'package:flutter/material.dart';

class TodoModel {
  String id;
  String taskName;
  String dueDate;
  String type;
  bool status;

  TodoModel(
      {required this.id,
      required this.taskName,
      required this.dueDate,
      required this.type,
      required this.status});
}
