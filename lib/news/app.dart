import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_infinite_list/news/cubit/news_cubit.dart';
import 'package:flutter_infinite_list/news/view/news_page.dart';

class AppNews extends MaterialApp {
  AppNews() : super(
    title: 'Flutter Infinite Scroll',
    home: CubitProvider(
      create: (_) => NewsCubit(),
      child: NewsPage(),
    ),
  );
}