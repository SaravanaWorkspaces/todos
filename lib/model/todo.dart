import 'package:equatable/equatable.dart';

class TodoFields {
  static String ID = "id";
  static String TODO = "todo";
  static String TODAY = "today";
  static String DESC = "desc";
  static String CREATEDTS = "createdTs";
  static String MODIFIEDTS = "modifiedTs";
}

class Todo extends Equatable {
  final int? id;
  final String todo;
  final bool today;
  final String? desc;
  final int createdTs;
  final int modifiedTs;

  const Todo(this.todo, this.today, this.desc, this.createdTs, this.modifiedTs, [this.id]);
  
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

  Todo fromMap(Map<String, Object?> map) {
    Todo obj = {
      todo : map[TodoFields.TODO],
      today : map[TodoFields.TODAY],
      desc : map[TodoFields.DESC],
      createdTs : map[TodoFields.CREATEDTS],
      modifiedTs : map[TodoFields.MODIFIEDTS],
    } as Todo;
    return obj;
  }
}