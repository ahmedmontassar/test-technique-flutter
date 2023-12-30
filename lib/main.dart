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
      home: MyHomePage(        title: 'Liste d\'articles',),
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
   bool isRefreshing = false; // Added this variable to track the refreshing state
     bool isLoading = true; // Added this variable to track the loading state


  @override
  void initState() {
     // Initialize httpClient before using it in initState
    httpClient = HttpClient();

    getarticleList();
    super.initState();
  }

Future<void> _handleRefresh() async {
    // Perform refresh operation here
    await getarticleList();
  }

  getarticleList() async {
    print("bastı");
    setState(() {
      isRefreshing = true; // Set refreshing state to true
            isLoading = true; // Set loading state to true

    });

    await httpClient.getarticleList().then((r) {
      setState(() {
        todoList = PostsResponse.fromJson(r.data).todoList;
        data = todoList[0].title;
        isRefreshing = false; // Set refreshing state to false after updating the list
                isLoading = false; // Set loading state to false after updating the list

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
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: todoList.length,
        itemBuilder: (context, pos) {
          return ListItem(
            posts: todoList[pos],
          );
        },
      ),
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
            child: Icon(Icons.refresh),
          ),
          GestureDetector(
            onTap: () {
              getarticleList();
            },
            child: Icon(Icons.cloud_download),
          ),
        ],
      ),
    body: Center(
        child: isLoading
            ? progressDialog() // Show loading indicator
            : isRefreshing
                ? progressDialog() // Show refreshing indicator
                : todoList.length == 0
                    ? Text('No data available.')
                    : getarticleListWidget(),
      ),
    );
  }
}
