import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/model/todo.dart';
import 'package:todos/todo/bloc/todo_bloc.dart';
import 'package:todos/todo/bloc/todo_event.dart';
import 'package:todos/todo/bloc/todo_state.dart';
import 'package:todos/utils/constants.dart';

class AddEditTodoScreen extends StatefulWidget {
  final int? todoId;
  const AddEditTodoScreen({Key? key, this.todoId}) : super(key: key);

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (_) => TodoBloc(TodoInitial()),
      child: AddEditPage(todoId: widget.todoId),
    );
  }
}

class AddEditPage extends StatefulWidget {
  final int? todoId;
  const AddEditPage({Key? key, this.todoId}) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  bool editTodo = false;
  bool isTodayChecked = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _todoTFFController = TextEditingController();
  final TextEditingController _descTFFController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    editTodo = widget.todoId != null ? true : false;
    if (editTodo) {
      context.read<TodoBloc>().add(GetTodoDetail(widget.todoId!));
    }
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
                if (editTodo) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<TodoBloc>().add(
                      EditTodo(widget.todoId!, modifiedTs, todo, desc, today));
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<TodoBloc>().add(AddTodo(todoObj));
                }
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
        child: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) => {
            if (state is AddTodoSuccess || state is EditTodoSuccess)
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
          buildWhen: (context, state) {
            if (state is TodoDetail) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            Todo? todo;
            if (state is TodoDetail) {
              todo = state.todo;
              _todoTFFController.text = todo.todo;
              _descTFFController.text = todo.desc;
              isTodayChecked = todo.today;
            }
            return Form(
                child: Column(
              children: [
                _todoTextFormField(),
                _todayCheckbox(),
                _descTextFormField(),
              ],
            ));
          },
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
        labelText: Constants.TODO_TAB_TITLE,
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
      return Constants.COMMON_INPUT_VALIDATION;
    }
    return null;
  }
}
