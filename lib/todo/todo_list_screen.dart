import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/todo/bloc/add_edit_todo_bloc.dart';
import 'package:todos/todo/bloc/add_edit_todo_event.dart';

import 'bloc/add_edit_todo_state.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodoList();
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(FetchAllTodo());
    return BlocBuilder<TodoBloc, AddEditTodoState>(
      builder: (context, state) {
        if (state is TodoListFetched) {
          return const Center(child: Text("Load list"));
        }
        return const Center(child: Text("TODO list is empty"));
      },
    );
  }
}
