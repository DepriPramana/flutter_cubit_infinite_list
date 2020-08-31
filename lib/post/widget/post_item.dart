import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/post/model/model.dart';

class PostItem extends StatelessWidget {
  final Post post;

  PostItem({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${post.id}', style: TextStyle(fontSize: 10)),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: false,
    );
  }
}