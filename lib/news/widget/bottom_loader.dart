import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: SizedBox(
          width: 32, height: 32,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      ),
    );
  }
}