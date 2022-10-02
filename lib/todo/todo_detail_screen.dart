import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/router_settings.dart';
import 'package:todos/todo/bloc/todo_bloc.dart';
import 'package:todos/todo/bloc/todo_event.dart';
import 'package:todos/todo/bloc/todo_state.dart';
import 'package:todos/utils/constants.dart';
import 'package:todos/utils/utility.dart';

class TodoDetailScreen extends StatefulWidget {
  final int todoId;
  const TodoDetailScreen({Key? key, required this.todoId}) : super(key: key);

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => TodoBloc(TodoInitial()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Constants.TODO),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouterSettings.ADD_EDIT_TODO,
                      arguments: widget.todoId);
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        body: DetailScreenBody(todoId: widget.todoId),
      ),
    );
  }
}

class DetailScreenBody extends StatefulWidget {
  final int todoId;
  const DetailScreenBody({Key? key, required this.todoId}) : super(key: key);

  @override
  State<DetailScreenBody> createState() => _DetailScreenBodyState();
}

class _DetailScreenBodyState extends State<DetailScreenBody> {
  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(GetTodoDetail(widget.todoId));
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoDetail) {
          final todo = state.todo;
          return Container(
            padding:
                const EdgeInsets.only(left: 12, top: 16, right: 12, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleWidget(todo.todo),
                const SizedBox(height: 10),
                _buildCreatedDateAndStatus(
                    Utility.tsToDate(todo.modifiedTs, Constants.DATE_FOAMAT_2),
                    "Completed"),
                const SizedBox(height: 10),
                _buildLabel(Constants.MODIFIED_ON),
                _buildLabelValue(
                    Utility.tsToDate(todo.modifiedTs, Constants.DATE_FOAMAT_2)),
                const SizedBox(height: 25),
                _buildLabel(Constants.DESCRIPTION),
                _buildDescriptionWidget(todo.desc),
              ],
            ),
          );
        } else if (state is TodoNotExists) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text(Constants.SOMETHING_WENT_WRONG),
          );
        }
      },
      buildWhen: (previous, current) {
        print("Build when ${previous} ${current}");
        return true;
      },
    );
  }

  _buildTitleWidget(String text) {
    print("_buildTitleWidget rendered $text");
    return Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: Text(text, style: const TextStyle(fontSize: 18.0)));
  }

  _buildLabel(String text) {
    return Text(text, style: TextStyle(color: Colors.grey[600]));
  }

  _buildLabelValue(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Text(text),
    );
  }

  _buildDescriptionWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Text(text, style: const TextStyle(fontSize: 15.0)),
    );
  }

  _buildCreatedDateAndStatus(String dateText, String status) {
    return Row(children: [
      _buildCreatedDate(dateText),
      _buildStatus(status),
    ]);
  }

  _buildCreatedDate(String text) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(Constants.CREATED_ON),
          _buildLabelValue(text),
        ],
      ),
    );
  }

  _buildStatus(String text) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildLabel(Constants.STATUS),
          _buildLabelValue(text),
        ],
      ),
    );
  }
}
