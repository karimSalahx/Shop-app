import 'package:flutter/material.dart';

class CustomHeadLineText extends StatelessWidget {
  final String title;
  CustomHeadLineText(this.title);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        this.title,
        style:
            Theme.of(context).textTheme.headline3.copyWith(color: Colors.black),
        textAlign: TextAlign.left,
      ),
    );
  }
}
