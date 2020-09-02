import 'package:flutter/material.dart';

class CheckScrollController extends ScrollController {
  CheckScrollController() : super();

  bool get isAtBottom {
    final offsetFromBottom = 25;
    final currentScroll = offset;
    final maxScroll = position.maxScrollExtent;
    return currentScroll >= maxScroll - offsetFromBottom;
  }
}