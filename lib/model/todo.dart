import 'package:equatable/equatable.dart';

class TodoFields {
  static const String ID = "id";
  static const String TODO = "todo";
  static const String TODAY = "today";
  static const String DESC = "desc";
  static const String CREATEDTS = "createdTs";
  static const String MODIFIEDTS = "modifiedTs";
}

class Todo extends Equatable {
  final int? id;
  final String todo;
  final bool today;
  final String? desc;
  final int createdTs;
  final int modifiedTs;

  const Todo({this.id, required this.todo, required this.today, required this.desc, 
  required this.createdTs, required this.modifiedTs});
  
  @override
  List<Object?> get props => [];

  Map<String, Object?> toMap() {
     var map = <String, Object?> {
      TodoFields.TODO  : todo,
      TodoFields.TODAY : today == true ? "true" : "false",
      TodoFields.DESC  : desc,
      TodoFields.CREATEDTS  : createdTs,
      TodoFields.MODIFIEDTS  : modifiedTs,
     };
     return map;
  }

  static Todo fromMap(Map<String, Object?> map) => Todo(
    id: map[TodoFields.ID] as int,
    todo : map[TodoFields.TODO] as String, 
    today: map[TodoFields.TODAY] as String == "true" ? true : false, 
    desc:map[TodoFields.DESC] as String,
    createdTs : map[TodoFields.CREATEDTS] as int, 
    modifiedTs: map[TodoFields.MODIFIEDTS] as int);
}