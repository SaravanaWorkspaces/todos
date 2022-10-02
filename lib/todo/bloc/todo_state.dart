import 'package:equatable/equatable.dart';
import 'package:todos/model/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class AddTodoSuccess extends TodoState {}

class AddTodoFailed extends TodoState {
  final String? message;
  const AddTodoFailed(this.message);
}

class TodoListFetched extends TodoState {
  final List<Todo> todoList;
  const TodoListFetched(this.todoList);

   @override
  List<Object> get props => [todoList];
}

class TodoListEmpty extends TodoState {
}

class TodoListFetchFailed extends TodoState {
  final String? message;
  const TodoListFetchFailed(this.message);
}

class TodoDetail extends TodoState {
  final Todo todo;
  const TodoDetail(this.todo);
  @override
  List<Todo> get props => [todo];
}

class TodoNotExists extends TodoState {
  final String message;
  const TodoNotExists(this.message);
}

class EditTodoSuccess extends TodoState {}
class EditTodoFailed extends TodoState {
  final String? message;
  const EditTodoFailed(this.message);
}