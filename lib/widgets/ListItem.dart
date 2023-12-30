import 'package:flutter/material.dart';
import 'package:test_tech/models/Todo.dart';
import 'package:test_tech/screens/TodoDetail.dart';

class ListItem extends StatelessWidget {
  final Todo todo;
  const ListItem({Key? key,required this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TodoDetail(todo: todo,)),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("title: ${todo.title}"),
              Text("id: ${todo.id}"),
              Text("userId: ${todo.userId}"),
              Text(
                "completed: ${todo.completed}",
                style: TextStyle(
                    backgroundColor:
                        todo.completed == true ? Colors.green : Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
