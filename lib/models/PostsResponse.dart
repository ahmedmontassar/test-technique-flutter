import 'package:test_tech/models/Posts.dart';


class PostsResponse{
  final List<Posts> todoList;
  PostsResponse({required this.todoList});

  factory PostsResponse.fromJson(List<dynamic> json){
  return PostsResponse(
    todoList: json.map((i)=>Posts.fromJson(i)).toList()
  );
}
}