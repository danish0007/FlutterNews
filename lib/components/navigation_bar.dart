import 'package:exam1/Screens/home_screen.dart';
import 'package:exam1/Screens/science_screen.dart';
import 'package:exam1/Screens/search_screen.dart';
import 'package:exam1/Screens/trending_screen.dart';
import 'package:exam1/Screens/world_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black54,
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: 14,
      selectedFontSize: 16,
      unselectedIconTheme: IconThemeData(size: 18),
      selectedIconTheme: IconThemeData(size: 21),
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.tealAccent,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.id);
              index = 0;
            },
          ),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.trending_up),
            onPressed: () {
              Navigator.pushNamed(context, TrendingScreen.id);
              index = 1;
            },
          ),
          title: Text('Trending'),
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.id);
              index = 2;
            },
          ),
          title: Text('Search'),
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(MdiIcons.flaskOutline),
            onPressed: () {
              Navigator.pushNamed(context, ScienceScreen.id);
              index = 3;
            },
          ),
          title: Text('Science'),
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              Navigator.pushNamed(context, WorldScreen.id);
              index = 4;
            },
          ),
          title: Text('World'),
        ),
      ],
      onTap: (newindex) {
        setState(() {
          index = newindex;
        });
      },
    );
  }
}

/*
class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.tealAccent,
      unselectedItemColor: Colors.white,
      currentIndex: index,
      onTap: (int i) {
        setState(() {
          index = i;
        });
      },
      items: [
        BottomNavigationBarItem(
          title: Text('Home'),
          icon: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
        ),
        BottomNavigationBarItem(
          title: Text('Trending'),
          icon: IconButton(
            icon: Icon(Icons.trending_up),
            onPressed: () {
              Navigator.pushNamed(context, TrendingScreen.id);
            },
          ),
        ),
        BottomNavigationBarItem(
          title: Text('Search'),
          icon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.id);
            },
          ),
        ),
        BottomNavigationBarItem(
          title: Text('World'),
          icon: IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              Navigator.pushNamed(context, WorldScreen.id);
            },
          ),
        ),
        BottomNavigationBarItem(
          title: Text('Science'),
          icon: IconButton(
            icon: Icon(MdiIcons.flaskOutline),
            onPressed: () {
              Navigator.pushNamed(context, ScienceScreen.id);
            },
          ),
        ),
      ],
    );
  }
}
*/
