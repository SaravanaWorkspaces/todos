import 'package:equatable/equatable.dart';
import 'package:todos/model/todo.dart';

abstract class AddEditTodoState extends Equatable {
  const AddEditTodoState();

   @override
  List<Object> get props => [];
}

class AddTodoInitial extends AddEditTodoState {}

class AddTodoSuccess extends AddEditTodoState {}

class AddTodoFailed extends AddEditTodoState {
  final String? message;
  const AddTodoFailed(this.message);
}

class TodoListFetched extends AddEditTodoState {
  final List<Todo> todoList;
  const TodoListFetched(this.todoList);
}

class TodoListFetchFailed extends AddEditTodoState {
  final String? message;
  const TodoListFetchFailed(this.message);
}
