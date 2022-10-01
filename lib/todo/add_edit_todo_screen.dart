import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/model/todo.dart';
import 'package:todos/todo/bloc/todo_bloc.dart';
import 'package:todos/todo/bloc/todo_event.dart';
import 'package:todos/todo/bloc/todo_state.dart';
import 'package:todos/utils/constants.dart';

class AddEditTodoScreen extends StatefulWidget {
  const AddEditTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (_) => TodoBloc(AddTodoInitial()),
      child: const AddEditPage(),
    );
  }
}

class AddEditPage extends StatefulWidget {
  const AddEditPage({Key? key}) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  bool isTodayChecked = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _todoTFFController = TextEditingController();
  final TextEditingController _descTFFController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.ADD_EDIT_TODO),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState != null &&
                  _formKey.currentState!.validate()) {
                String todo = _todoTFFController.text;
                String desc = _descTFFController.text;
                bool today = isTodayChecked;
                int createdTs = DateTime.now().millisecondsSinceEpoch;
                int modifiedTs = DateTime.now().millisecondsSinceEpoch;
                final todoObj = Todo(
                    todo: todo,
                    today: today,
                    desc: desc,
                    createdTs: createdTs,
                    modifiedTs: modifiedTs);
                context.read<TodoBloc>().add(AddTodo(todoObj));
              }
            },
            icon: const Icon(Icons.done),
            color: Colors.white,
          )
        ],
      ),
      body: _pageContent(),
    );
  }

  Container _pageContent() {
    return Container(
      padding:
          const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
      child: Form(
        key: _formKey,
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) => {
            if (state is AddTodoSuccess)
              {Navigator.pop(context)}
            else if (state is AddTodoFailed)
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message ?? "Failed"),
                  ),
                )
              }
          },
          child: Column(
            children: [
              _todoTextFormField(),
              _todayCheckbox(),
              _descTextFormField(),
            ],
          ),
        ),
      ),
    );
  }

  _todoTextFormField() {
    return TextFormField(
      maxLines: 1,
      maxLength: 32,
      controller: _todoTFFController,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Todo',
      ),
      validator: _inputFieldValidation,
    );
  }

  _todayCheckbox() {
    return Row(
      children: [
        Checkbox(
            value: isTodayChecked,
            onChanged: (changed) {
              setState(() {
                isTodayChecked = changed!;
              });
            }),
        const Text(Constants.TODAY)
      ],
    );
  }

  _descTextFormField() {
    return Expanded(
      child: TextFormField(
        minLines: 4,
        maxLines: 6,
        controller: _descTFFController,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: Constants.DESCRIPTION,
          alignLabelWithHint: true,
        ),
        validator: _inputFieldValidation,
      ),
    );
  }

  String? _inputFieldValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
