import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_tech/models/Posts.dart';
import 'package:test_tech/models/PostsResponse.dart';
import 'package:test_tech/rest/http_client.dart';
import 'package:test_tech/widgets/ListItem.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' test technique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ' liste d articles.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<Posts> todoList = [];

class _MyHomePageState extends State<MyHomePage> {
  String data = "Veri yok.";
 late  HttpClient httpClient;
  @override
  void initState() {
     // Initialize httpClient before using it in initState
    httpClient = HttpClient();

    getarticleList();
    super.initState();
  }

  getarticleList() {
    print("bastı");
    httpClient.getarticleList().then((r) {
      setState(() {
        todoList = PostsResponse.fromJson(r.data).todoList;
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

  Widget getarticleListWidget() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todoList.length,
      itemBuilder: (context, pos) {
        return ListItem(
          posts: todoList[pos],
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
                  getarticleList();
                },
                child: Icon(Icons.cloud_download)),
          ],
        ),
        body: Center(child: todoList.length == 0 ? progressDialog() : getarticleListWidget()));
  }
}
