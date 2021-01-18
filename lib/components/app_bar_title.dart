import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarTitle extends StatelessWidget {
  final String name;
  AppBarTitle(this.name);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$name',
          style: GoogleFonts.grenze(
              fontSize: 35,
              color: Theme.of(context).primaryTextTheme.headline1.color),
        ),
        Text(
          'News',
          style: GoogleFonts.grenze(
              fontSize: 35, color: Theme.of(context).accentColor),
        ),
      ],
    );
  }
}
