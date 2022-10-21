import 'package:equatable/equatable.dart';

class TodoFields {
  static const String ID = "id";
  static const String TODO = "todo";
  static const String DESC = "desc";
  static const String CREATEDTS = "createdTs";
  static const String MODIFIEDTS = "modifiedTs";
  static const String COMPLETED = "completed";
}

class Todo extends Equatable {
  final int? id;
  final String todo;
  final String desc;
  final int createdTs;
  final int modifiedTs;
  final bool completed;

  const Todo({this.id, required this.todo, required this.desc, 
  required this.createdTs, required this.modifiedTs, required this.completed});
  
  @override
  List<Object?> get props => [id, todo, desc, createdTs, modifiedTs];

  Map<String, Object?> toMap() {
     var map = <String, Object?> {
      TodoFields.TODO  : todo,
      TodoFields.DESC  : desc,
      TodoFields.CREATEDTS  : createdTs,
      TodoFields.MODIFIEDTS  : modifiedTs,
      TodoFields.COMPLETED : completed ? "true" : false
     };
     return map;
  }

  static Todo fromMap(Map<String, Object?> map) => Todo(
    id: map[TodoFields.ID] as int,
    todo : map[TodoFields.TODO] as String, 
    desc:map[TodoFields.DESC] as String,
    createdTs : map[TodoFields.CREATEDTS] as int, 
    modifiedTs: map[TodoFields.MODIFIEDTS] as int,
    completed: map[TodoFields.COMPLETED] as String == "true" ? true : false);
}