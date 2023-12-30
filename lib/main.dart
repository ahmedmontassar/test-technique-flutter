import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest/models/Todo.dart';
import 'package:rest/models/TodoResponse.dart';
import 'package:rest/rest/http_client.dart';
import 'package:rest/widgets/ListItem.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<Todo> todoList = new List();

class _MyHomePageState extends State<MyHomePage> {
  String data = "Veri yok.";
  HttpClient httpClient;
  @override
  void initState() {
    httpClient = new HttpClient();
    getTodoList();
    super.initState();
  }

  getTodoList() {
    print("bastı");
    httpClient.getTodoList().then((r) {
      setState(() {
        todoList = TodoResponse.fromJson(r.data).todoList;
        data = todoList[0].title;
      });
    });
  }

  Widget progressDialog() {
    return CircularProgressIndicator(
      value: null,
      strokeWidth: 2.0,
    );
  }

  Widget getTodoListWidget() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todoList.length,
      itemBuilder: (context, pos) {
        return ListItem(
          todo: todoList[pos],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  setState(() {
                    data = "Veriyi getir";
                  });
                },
                child: Icon(Icons.refresh)),
            GestureDetector(
                onTap: () {
                  getTodoList();
                },
                child: Icon(Icons.cloud_download)),
          ],
        ),
        body: Center(child: todoList.length == 0 ? progressDialog() : getTodoListWidget()));
  }
}
