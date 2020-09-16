import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:exam1/components/navigation_bar.dart';
import 'package:exam1/components/launch_in_app.dart';

const String Apikey = 'iPTJBfr8mJhrodrz5dx5QAIUKY31STF8';

class WorldScreen extends StatefulWidget {
  static String id = 'worldscreen';
  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  var article;
  Color colour = Colors.white;
  LaunchInApp lia = LaunchInApp();

  Future<void> getdata() async {
    http.Response response = await http.get(
        'https://api.nytimes.com/svc/topstories/v2/world.json?api-key=$Apikey');

    if (response.statusCode == 200) {
      setState(() {
        var data = jsonDecode(response.body);
        article = data['results'];
      });
      return "success";
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'World',
                style: GoogleFonts.grenze(fontSize: 35, color: Colors.white),
              ),
              Text(
                ' News',
                style: GoogleFonts.grenze(fontSize: 35, color: Colors.blue),
              ),
            ],
          )),
      body: ListView.builder(
          itemCount: article != null ? article.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: RaisedButton(
                        color: Colors.black45,
                        elevation: 16,
                        onPressed: () {
                          setState(() {
                            lia.launchInApp(article[index]['url']);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Image(
                                    image: NetworkImage(
                                        article[index]['multimedia'][0]['url']),
                                    height: 300,
                                    width: double.maxFinite,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      SizedBox(height: 200),
                                      Text(
                                        article[index]['title'],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.notoSerif(
                                            fontSize: 22,
                                            backgroundColor: Colors.black45,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                article[index]['abstract'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                    fontSize: 20, fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.favorite, color: colour),
                                    onPressed: () {
                                      setState(() {
                                        colour = colour == Colors.white
                                            ? Colors.red
                                            : Colors.white;
                                      });
                                    },
                                  ),
                                  Text(
                                    ('${article[index]['published_date']}')
                                        .substring(0, 10),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
