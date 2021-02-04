import 'package:flutter/material.dart';

class PublishDateCell extends StatelessWidget {
  final int index;
  final article;
  PublishDateCell({this.article, this.index});

  @override
  Widget build(BuildContext context) {
    return Text(
      ('${article[index]['published_date']}').substring(0, 10),
      textAlign: TextAlign.right,
      style: TextStyle(
          color: Theme.of(context).textTheme.headline2.color, fontSize: 20),
    );
  }
}
