import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/db/db_helper.dart';
import 'package:todos/todo/bloc/add_edit_todo_event.dart';
import 'package:todos/todo/bloc/add_edit_todo_state.dart';

class AddEditTodoBloc extends Bloc<AddEditTodoEvent, AddEditTodoState> {
  AddEditTodoBloc(AddTodoInitial initial) : super(initial) {
   on<AddTodo>(_insertTodo);
  }

  void _insertTodo(AddTodo event, Emitter<AddEditTodoState> emit) async {
    try {
      await DatabaseHelper().insertTodo(event.todo);
      emit(AddTodoSuccess());
    } catch(e) {
      emit(AddTodoFailed(e.toString()));
    }
  }
}