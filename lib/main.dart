import 'package:exam1/Screens/science_screen.dart';
import 'package:exam1/Screens/search_screen.dart';
import 'package:exam1/Screens/trending_screen.dart';
import 'package:exam1/Screens/world_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exam1/Screens/home_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
  bool themeContent = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeContent
          ? ThemeData.dark().copyWith(
              accentColor: Colors.red,
              primaryTextTheme:
                  TextTheme(headline1: TextStyle(color: Colors.white)))
          : ThemeData(
              primaryColor: Colors.white,
              accentColor: Colors.blue,
              primaryTextTheme:
                  TextTheme(headline1: TextStyle(color: Colors.black))),
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
              ),
              DrawerTile(
                name: "Trending New",
                icon: Icon(
                  Icons.trending_up,
                  size: 30,
                ),
              ),
              DrawerTile(
                name: "Search News",
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
              DrawerTile(
                name: "Science & Technology News",
                icon: Icon(MdiIcons.flaskOutline, size: 30),
              ),
              DrawerTile(
                name: "World News",
                icon: Icon(
                  Icons.language,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 100,
              ),
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: themeContent ? Colors.black54 : Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 20),
          unselectedLabelStyle: TextStyle(fontSize: 18),
          unselectedIconTheme: IconThemeData(size: 22),
          selectedIconTheme: IconThemeData(size: 24),
          unselectedItemColor: themeContent ? Colors.white : Colors.black,
          selectedItemColor:
              themeContent ? Colors.redAccent : Colors.blueAccent,
          currentIndex: selectedPage,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
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
          onTap: (newindex) {
            setState(() {
              selectedPage = newindex;
              _pageController.animateToPage(newindex,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
          },
        ),
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

class DrawerTile extends StatelessWidget {
  final Icon icon;
  final String name;

  DrawerTile({this.icon, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: icon,
        title: Text(
          "$name",
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      ),
    );
  }
}
