import 'package:exam1/Screens/science_screen.dart';
import 'package:exam1/Screens/search_screen.dart';
import 'package:exam1/Screens/trending_screen.dart';
import 'package:exam1/Screens/world_screen.dart';
import 'package:flutter/material.dart';
import 'package:exam1/Screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        WorldScreen.id: (context) => WorldScreen(),
        TrendingScreen.id: (context) => TrendingScreen(),
        SearchScreen.id: (context) => SearchScreen(),
        ScienceScreen.id: (context) => ScienceScreen(),
      },
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
