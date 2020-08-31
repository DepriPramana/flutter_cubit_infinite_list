import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/news/view/news_list.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Indonesia'),
      ),
      body: NewsList(),
    );
  }
}