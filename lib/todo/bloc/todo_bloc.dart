import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/db/db_helper.dart';
import 'package:todos/todo/bloc/todo_event.dart';
import 'package:todos/todo/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(TodoInitial initial) : super(initial) {
   on<AddTodo>(_insertTodo);
   on<FetchAllTodo>(_fetchAllTodo);
   on<GetTodoDetail>(_getTodoById);
  }

  void _insertTodo(AddTodo event, Emitter<TodoState> emit) async {
    try {
      await DatabaseHelper().insertTodo(event.todo);
      emit(AddTodoSuccess());
    } catch(e) {
      emit(AddTodoFailed(e.toString()));
    }
  }

  void _fetchAllTodo(FetchAllTodo event, Emitter<TodoState> emit) async {
    try {
      final todoList = await DatabaseHelper().fetchTodoList();
      if(todoList.isEmpty) {
        emit(TodoListEmpty());  
        return;
      }
      emit(TodoListFetched(todoList));
    } catch(e) {
      emit(TodoListFetchFailed(e.toString()));
    }    
  }

  void _getTodoById(GetTodoDetail event, Emitter<TodoState> emit) async {
    try {
      final todo = await DatabaseHelper().getTodoById(event.id);
      emit(TodoDetail(todo));
    } catch(e) {
      emit(TodoNotExists(e.toString()));
    }
  }
}