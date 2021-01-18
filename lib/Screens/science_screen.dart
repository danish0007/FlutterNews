import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:exam1/components/launch_in_app.dart';
import 'package:exam1/components/app_bar_title.dart';

const String Apikey = 'iPTJBfr8mJhrodrz5dx5QAIUKY31STF8';

class ScienceScreen extends StatefulWidget {
  static String id = "sciencescreen";
  @override
  _ScienceScreenState createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen> {
  var article;
  Color colour = Colors.white;
  LaunchInApp lia = LaunchInApp();

  Future<void> getdata() async {
    http.Response response = await http.get(
        'https://api.nytimes.com/svc/topstories/v2/science.json?api-key=$Apikey');

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
      appBar: AppBar(
        title: AppBarTitle("Science"),
      ),
      body: ListView.builder(
          itemCount: article != null ? article.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      elevation: 16,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            lia.launchInApp(article[index]['url']);
                          });
                        },
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(article[index]
                                          ['multimedia'][0]['url']),
                                    )),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        article[index]['title'],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.notoSerif(
                                            fontSize: 22,
                                            color: Colors.white,
                                            backgroundColor: Colors.black87),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                article[index]['abstract'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                    fontSize: 20, fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 10),
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
                                        color: Colors.white70, fontSize: 16),
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
