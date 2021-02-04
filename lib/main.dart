import 'package:exam1/Screens/science_screen.dart';
import 'package:exam1/Screens/search_screen.dart';
import 'package:exam1/Screens/trending_screen.dart';
import 'package:exam1/Screens/world_screen.dart';
import 'package:flutter/material.dart';
import 'package:exam1/Screens/home_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:exam1/components/drawer_tile.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  bool themeContent = false;

  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = true;
  bool showUnselectedLabels = true;

  Color selectedColor = Colors.black;
  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);

  Color unselectedColor = Colors.white;
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeContent
          ? ThemeData.dark().copyWith(
              accentColor: Colors.red,
              primaryTextTheme: TextTheme(
                  headline1: TextStyle(color: Colors.white),
                  headline2: TextStyle(color: Colors.white)))
          : ThemeData(
              primaryColor: Colors.white,
              accentColor: Colors.blue,
              primaryTextTheme: TextTheme(
                  headline1: TextStyle(color: Colors.black),
                  headline2: TextStyle(color: Colors.black87))),
      home: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountEmail: Text(
                  "danishmultani2001@gmail.com",
                  style: TextStyle(fontSize: 16),
                ),
                accountName: Text(
                  "Danish",
                  style: TextStyle(fontSize: 20),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: themeContent ? Colors.red : Colors.blue,
                  child: Text(
                    "DM",
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
                otherAccountsPictures: [
                  CircleAvatar(
                    backgroundColor: themeContent ? Colors.red : Colors.blue,
                    child: Text(
                      'BM',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: themeContent ? Colors.red : Colors.blue,
                    child: Text(
                      "SM",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
              DrawerTile(
                name: "Home",
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
                page: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              DrawerTile(
                name: "Trending New",
                icon: Icon(
                  Icons.trending_up,
                  size: 30,
                ),
                page: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TrendingScreen()));
                },
              ),
              DrawerTile(
                name: "Search News",
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                page: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
              ),
              DrawerTile(
                name: "Science & Technology News",
                icon: Icon(MdiIcons.flaskOutline, size: 30),
                page: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ScienceScreen()));
                },
              ),
              DrawerTile(
                name: "World News",
                icon: Icon(
                  Icons.language,
                  size: 30,
                ),
                page: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WorldScreen()));
                },
              ),
              SizedBox(height: 100),
              ListTile(
                title: Text(
                  'Enable Dark Theme',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Switch(
                  value: themeContent,
                  onChanged: (value) {
                    setState(() {
                      themeContent = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          padding: padding,
          selectedLabelStyle: TextStyle(color: Colors.white),
          unselectedLabelStyle:
              TextStyle(color: themeContent ? Colors.white : Colors.black),

          ///configuration for SnakeNavigationBar.color
          snakeViewColor: selectedColor,
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: themeContent ? Colors.white : Colors.black,

          ///configuration for SnakeNavigationBar.gradient
          //snakeViewGradient: selectedGradient,
          //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
          //unselectedItemGradient: unselectedGradient,

          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,

          currentIndex: selectedPage,
          onTap: (newindex) {
            setState(() {
              selectedPage = newindex;
              _pageController.animateToPage(newindex,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Trending',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.flaskOutline),
              label: 'Science',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.language),
              label: 'World',
            ),
          ],
        ),
        // BottomNavigationBar(
        //   backgroundColor: themeContent ? Colors.black54 : Colors.white,
        //   type: BottomNavigationBarType.fixed,
        //   selectedLabelStyle: TextStyle(fontSize: 16),
        //   unselectedLabelStyle: TextStyle(fontSize: 14),
        //   unselectedIconTheme: IconThemeData(size: 20),
        //   selectedIconTheme: IconThemeData(size: 24),
        //   unselectedItemColor: themeContent ? Colors.white : Colors.black,
        //   selectedItemColor:
        //       themeContent ? Colors.redAccent : Colors.blueAccent,
        //   currentIndex: selectedPage,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home_outlined),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.trending_up),
        //       label: 'Trending',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.search,
        //       ),
        //       label: 'Search',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(MdiIcons.flaskOutline),
        //       label: 'Science',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.language),
        //       label: 'World',
        //     ),
        //   ],
        //   onTap: (newindex) {
        //     setState(() {
        //       selectedPage = newindex;
        //       _pageController.animateToPage(newindex,
        //           duration: Duration(milliseconds: 500), curve: Curves.ease);
        //     });
        //   },
        // ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              selectedPage = index;
            });
          },
          children: [
            HomeScreen(),
            TrendingScreen(),
            SearchScreen(),
            ScienceScreen(),
            WorldScreen(),
          ],
        ),
      ),
    );
  }
}
