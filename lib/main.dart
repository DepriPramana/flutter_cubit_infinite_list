import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/news/app.dart';
import 'package:flutter_infinite_list/post/post.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  runApp(AppNews());
}