import 'package:flutter/material.dart';
import 'package:test_tech/models/Posts.dart';
import 'package:test_tech/screens/PostsDetail.dart';

class ListItem extends StatelessWidget {
  final Posts posts;
    final bool withDetails;

  const ListItem({Key? key,required this.posts ,     this.withDetails = false,}) : super(key: key);
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
              Text("title: ${posts.title}",  textAlign: TextAlign.center,
  textScaleFactor: 4.0,  style: TextStyle(
    color: Colors.blue,
      fontWeight: FontWeight.w300,
  ),),
              Text("id: ${posts.id}"),
              Text("userId: ${posts.userId}"),
                 if (withDetails) Text("body: ${posts.body}"),

            ],
          ),
        ),
      ),
    );
  }
}
