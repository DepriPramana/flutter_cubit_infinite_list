import 'package:flutter/material.dart';

class CheckScrollController extends ScrollController {
  CheckScrollController({this.offsetFromBottom=25}) : super();
  
  final int offsetFromBottom;

  bool get isAtBottom {
    final currentScroll = offset;
    final maxScroll = position.maxScrollExtent;
    return currentScroll >= maxScroll - offsetFromBottom;
  }
}