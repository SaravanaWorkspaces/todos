import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/model/todo.dart';
import 'package:todos/router_settings.dart';
import 'package:todos/todo/bloc/todo_bloc.dart';
import 'package:todos/todo/bloc/todo_event.dart';
import 'package:todos/utils/constants.dart';
import 'package:todos/utils/utility.dart';

import 'bloc/todo_state.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return TodoList();
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
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoListFetched) {
          return Container(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: TodoListView(
              todoList: state.todoList,
            ),
          );
        }
        return const Center(child: Text(Constants.TODO_LIST_EMPTY));
      },
    );
  }
}

class TodoListView extends StatefulWidget {
  final List<Todo> todoList;

  const TodoListView({Key? key, required this.todoList}) : super(key: key);

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
              onTap: () => Navigator.pushNamed(
                      context, RouterSettings.VIEW_TODO,
                      arguments: widget.todoList[index].id)
                  .then(
                      (value) => context.read<TodoBloc>().add(FetchAllTodo())),
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
                        style: const TextStyle(fontSize: 10.0),
                        Utility.tsToDate(widget.todoList[index].modifiedTs,
                            Constants.DATE_FOAMAT_2)),
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
