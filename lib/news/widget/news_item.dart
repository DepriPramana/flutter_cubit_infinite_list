import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/news/model/news.dart';
import 'package:gap/gap.dart';

class NewsItem extends StatelessWidget {
  final News item;

  NewsItem({Key key, this.item}) : super(key: key);

  Widget get _placeholder => Container(
    height: 120, 
    color: Color(0xffefefef),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
    ),
  );

  Widget get _thumbnail => CachedNetworkImage(
    imageUrl: item.image,
    imageBuilder: (_, image) => ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image(image: image),
    ),
    placeholder: (_, __) => _placeholder,
    errorWidget: (_, __, ___) => Container(),
    fadeInDuration: Duration(milliseconds: 250),
    fadeOutDuration: Duration(milliseconds: 250),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _thumbnail,
            Gap(8),
            Text(item.title),
            Gap(2),
          ],
        ),
        isThreeLine: true,
        subtitle: Text(item.summary),
        dense: false,
      ),
    );
  }
}