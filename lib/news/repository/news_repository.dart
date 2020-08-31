import 'dart:convert';
import 'package:flutter_infinite_list/news/api/api.dart';
import 'package:flutter_infinite_list/news/model/news.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  final httpClient = http.Client();

  Future<List<News>> fetch({int page=1, int limit=10}) async {
    final url = Api.search(keyword: 'indonesia', page: page, limit: limit);
    final response = await httpClient.get(url);
    
    if(response.statusCode == 200) {
      final data = json.decode(response.body);
      final articles = data['articles'] as List;
      return articles.map((item) => News.fromJson(item)).toList();
    } else {
      throw Exception('error fetching news');
    }
  }
}