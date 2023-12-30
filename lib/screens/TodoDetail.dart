import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_tech/models/Todo.dart';
import 'package:test_tech/rest/http_client.dart';
import 'package:test_tech/widgets/ListItem.dart';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  const TodoDetail({Key? key,required this.todo}) : super(key: key);

  @override
  _TodoDetailState createState() => _TodoDetailState();
}

  Todo newTodo = Todo(userId: 0, id: 0, title: '', completed: false); // Example initialization


Widget progressDialog() {
  return CircularProgressIndicator(
    value: null,
    strokeWidth: 2.0,
  );
}

class _TodoDetailState extends State<TodoDetail> {
  getSingleTodo(int id) {
    new HttpClient().getSingleTodo(id).then((r) {
      setState(() {
        newTodo = Todo.fromJson(r.data[0]);
      });
    });
  }

  @override
  void initState() {
    getSingleTodo(widget.todo.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo.title),
      ),
      body: Center(
        child: newTodo == null
            ? progressDialog()
            : Column(
                children: <Widget>[
                  ListItem(
                    todo: newTodo,
                  )
                ],
              ),
      ),
    );
  }
}
