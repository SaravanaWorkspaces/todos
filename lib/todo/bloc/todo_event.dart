import 'package:equatable/equatable.dart';
import 'package:todos/model/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class AddTodo extends TodoEvent {

  final Todo todo;
  const AddTodo(this.todo);

  @override
  List<Object?> get props => [];
}

class FetchAllTodo extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class GetTodoDetail extends TodoEvent {
  
  final int id;
  const GetTodoDetail(this.id);

  @override
  List<Object?> get props => [];
}

