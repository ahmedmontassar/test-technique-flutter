import 'package:flutter/material.dart';
import 'package:test_tech/models/Posts.dart';
import 'package:test_tech/screens/PostsDetail.dart';

class ListItem extends StatelessWidget {
  final Posts posts;
  const ListItem({Key? key,required this.posts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostsDetail(posts: posts,)),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("title: ${posts.title}"),
              Text("id: ${posts.id}"),
              Text("userId: ${posts.userId}"),
           
            ],
          ),
        ),
      ),
    );
  }
}
