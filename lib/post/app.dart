import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_infinite_list/post/post.dart';

class AppPost extends MaterialApp {
  AppPost() : super(
    title: 'Flutter Infinite Scroll',
    home: CubitProvider(
      create: (_) => PostCubit(),
      child: PostPage(),
    ),
  );
}