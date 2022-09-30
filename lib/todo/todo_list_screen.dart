import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/model/todo.dart';
import 'package:todos/router_settings.dart';
import 'package:todos/todo/bloc/add_edit_todo_bloc.dart';
import 'package:todos/todo/bloc/add_edit_todo_event.dart';
import 'package:todos/utils/utility.dart';

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
          return Container(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: TodoListView(
              todoList: state.todoList,
            ),
          );
        }
        return const Center(child: Text("TODO list is empty"));
      },
    );
  }
}

class TodoListView extends StatefulWidget {
  List<Todo> todoList;

  TodoListView({Key? key, required this.todoList}) : super(key: key);

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: ((context, index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
          child: Card(
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, RouterSettings.VIEW_TODO, arguments: index),
              child: Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                    child: Text(
                        style: const TextStyle(fontSize: 18.0),
                        widget.todoList[index].todo),
                  ),
                  Text(
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12.0),
                      Utility.tsToDate(widget.todoList[index].modifiedTs)),
                ],
              ),
            ),
            ),
          ),
        );
      }),
    );
  }
}
