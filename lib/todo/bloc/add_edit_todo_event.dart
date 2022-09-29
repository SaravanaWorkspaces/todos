import 'package:equatable/equatable.dart';
import 'package:todos/model/todo.dart';

abstract class AddEditTodoEvent extends Equatable {
  const AddEditTodoEvent();
}

class AddTodo extends AddEditTodoEvent {

  Todo todo;
  AddTodo(this.todo);

  @override
  List<Object?> get props => [];
}

class FetchAllTodo extends AddEditTodoEvent {
  @override
  List<Object?> get props => [];
}