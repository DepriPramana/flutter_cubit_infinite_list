import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_infinite_list/post/model/model.dart';

class PostRepository {
  final httpClient = http.Client();

  Future<List<Post>> fetch({int start=0, int limit=20}) async {
    final response = await httpClient.get(
      'https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$limit');

    if(response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((item) => Post(
        id: item['id'],
        title: item['title'],
        body: item['body'],
      )).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}