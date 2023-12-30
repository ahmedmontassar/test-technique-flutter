import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_tech/models/Posts.dart';
import 'package:test_tech/rest/http_client.dart';
import 'package:test_tech/widgets/ListItem.dart';

class PostsDetail extends StatefulWidget {
  final Posts posts;
  const PostsDetail({Key? key,required this.posts}) : super(key: key);

  @override
  _PostsDetailState createState() => _PostsDetailState();
}

  Posts newPosts = Posts(userId: 0, id: 0, title: '',body:'' ); // Example initialization


Widget progressDialog() {
  return CircularProgressIndicator(
    value: null,
    strokeWidth: 2.0,
  );
}

class _PostsDetailState extends State<PostsDetail> {
  getSinglePosts(int id) {
    new HttpClient().getSinglePosts(id).then((r) {
      setState(() {
        newPosts = Posts.fromJson(r.data[0]);
      });
    });
  }

  @override
  void initState() {
    getSinglePosts(widget.posts.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.posts.title),
      ),
      body: Center(
        child: newPosts == null
            ? progressDialog()
            : Column(
                children: <Widget>[
                  ListItem(
                    posts: newPosts,  withDetails: true,
                  )
                ],
              ),
      ),
    );
  }
}
