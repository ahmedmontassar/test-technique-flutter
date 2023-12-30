import 'package:rest/models/Todo.dart';

class TodoResponse{
  final List<Todo> todoList;
  TodoResponse({this.todoList});

  factory TodoResponse.fromJson(List<dynamic> json){
  return TodoResponse(
    todoList: json.map((i)=>Todo.fromJson(i)).toList()
  );
}
}