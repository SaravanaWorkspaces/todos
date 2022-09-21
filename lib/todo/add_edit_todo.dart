import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todos/utils/constants.dart';

class AddEditTodoScreen extends StatelessWidget {
  const AddEditTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.ADD_EDIT_TODO),
      ),
      body: Text("data"),
    );
  }
}