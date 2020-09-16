import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:exam1/components/navigation_bar.dart';
import 'package:exam1/components/launch_in_app.dart';

const String Apikey = 'iPTJBfr8mJhrodrz5dx5QAIUKY31STF8';

class SearchScreen extends StatefulWidget {
  static String id = 'searchscreen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var article;
  Color colour = Colors.white;
  LaunchInApp lia = LaunchInApp();

  Future<void> getdata(String inputtext) async {
    http.Response response = await http.get(
        'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=$inputtext&api-key=$Apikey');

    if (response.statusCode == 200) {
      setState(() {
        var data = jsonDecode(response.body);
        article = data['response'];
      });
      return "success";
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          style: GoogleFonts.notoSerif(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'Search Here',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 12),
          ),
          onSubmitted: (text) {
            String searchtext = text;
            getdata(searchtext);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: article != null ? article['docs'].length : 0,
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
                          lia.launchInApp(article['docs'][index]['web_url']);
                        });
                      },
                      //response.docs[0].web_url
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            Text(
                              (article['docs'][index]['abstract']),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.notoSerif(
                                  fontSize: 22, color: Colors.white),
                            ),
                            SizedBox(height: 15),
                            Text(
                              article['docs'][index]['lead_paragraph'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                  fontSize: 20, fontStyle: FontStyle.italic),
                            ),
                            SizedBox(height: 10),
                            Row(
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
                                  ('${article['docs'][index]['pub_date']}')
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
        },
      ),
    );
  }
}
