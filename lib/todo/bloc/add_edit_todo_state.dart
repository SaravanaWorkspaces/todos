import 'package:equatable/equatable.dart';

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

