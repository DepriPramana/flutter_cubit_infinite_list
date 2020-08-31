import 'package:equatable/equatable.dart';

class News extends Equatable {
  final int id;
  final String title;
  final String summary;
  final String url;
  final String content;
  final String image;
  final String publishedAt;

  News({
    this.id, 
    this.title, 
    this.summary, 
    this.url, 
    this.content, 
    this.image, 
    this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json['url'].hashCode,
    title: json['title'],
    summary: json['description'],
    url: json['url'],
    content: json['content'],
    image: json['urlToImage'],
    publishedAt: json['publishedAt'],
  );

  @override
  List<Object> get props => [id, title, summary, url, content, image, publishedAt];
}