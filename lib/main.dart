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
   bool isRefreshing = false; 
     bool isLoading = true; 
  String errorMessage = ''; 


  @override
  void initState() {

    httpClient = HttpClient();

    getarticleList();
    super.initState();
  }

Future<void> _handleRefresh() async {
 
    await getarticleList();
  }

  getarticleList() async {
    print("bastı");
    setState(() {
      isRefreshing = true; 
            isLoading = true;
   errorMessage = ''; 
    });

  try {
      final response = await httpClient.getarticleList();
      setState(() {
        todoList = PostsResponse.fromJson(response.data).todoList;
        data = todoList.isNotEmpty ? todoList[0].title : 'No data available';
        isRefreshing = false;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error fetching data. Please try again.';
        isRefreshing = false;
        isLoading = false;
      });
    }
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
            ? progressDialog()
            : isRefreshing
                ? progressDialog()
                : errorMessage.isNotEmpty
                    ? Text(errorMessage)
                    : todoList.length == 0
                        ? Text('No data available.')
                        : getarticleListWidget(),
      ),
    );
  }
}
