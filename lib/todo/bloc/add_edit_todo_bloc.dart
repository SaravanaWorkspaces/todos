import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/db/db_helper.dart';
import 'package:todos/todo/bloc/add_edit_todo_event.dart';
import 'package:todos/todo/bloc/add_edit_todo_state.dart';

class TodoBloc extends Bloc<AddEditTodoEvent, AddEditTodoState> {
  TodoBloc(AddTodoInitial initial) : super(initial) {
   on<AddTodo>(_insertTodo);
   on<FetchAllTodo>(_fetchAllTodo);
  }

  void _insertTodo(AddTodo event, Emitter<AddEditTodoState> emit) async {
    try {
      await DatabaseHelper().insertTodo(event.todo);
      emit(AddTodoSuccess());
    } catch(e) {
      emit(AddTodoFailed(e.toString()));
    }
  }

  void _fetchAllTodo(FetchAllTodo event, Emitter<AddEditTodoState> emit) async {
    try {
      final todoList = await DatabaseHelper().fetchTodoList();
      emit(TodoListFetched(todoList));
    } catch(e) {
      emit(TodoListFetchFailed(e.toString()));
    }
  }
}