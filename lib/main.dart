import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_tech/models/Todo.dart';
import 'package:test_tech/models/TodoResponse.dart';
import 'package:test_tech/rest/http_client.dart';
import 'package:test_tech/widgets/ListItem.dart';

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
MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<Todo> todoList = [];

class _MyHomePageState extends State<MyHomePage> {
  String data = "Veri yok.";
 late  HttpClient httpClient;
  @override
  void initState() {
     // Initialize httpClient before using it in initState
    httpClient = HttpClient();

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
