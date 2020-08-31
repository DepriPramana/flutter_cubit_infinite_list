import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/post/view/view.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Posts'),
      ),
      body: PostList(),
    );
  }
}