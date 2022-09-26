import 'package:equatable/equatable.dart';

class TodoFields {
  static String ID = "id INTEGER PRIMARY KEY AUTOINCREMENT";
  static String TODO = "todo TEXT";
  static String TODAY = "today TEXT";
  static String DESC = "desc TEXT";
  static String CREATEDTS = "createdTs INTEGER";
  static String MODIFIEDTS = "modifiedTs INTEGER";
}

class Todo extends Equatable {
  
  final String todo;
  final bool today;
  final String? desc;
  final int createdTs;
  final int modifiedTs;

  const Todo(this.todo, this.today, this.desc, this.createdTs, this.modifiedTs);
  
  @override
  List<Object?> get props => [];
}