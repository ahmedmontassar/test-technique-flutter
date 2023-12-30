import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest/models/Todo.dart';
import 'package:rest/rest/http_client.dart';
import 'package:rest/widgets/ListItem.dart';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  const TodoDetail({Key key, this.todo}) : super(key: key);

  @override
  _TodoDetailState createState() => _TodoDetailState();
}

Todo newTodo;

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
