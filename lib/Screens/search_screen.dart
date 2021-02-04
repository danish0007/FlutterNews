import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:exam1/components/launch_in_app.dart';

const String Apikey = 'iPTJBfr8mJhrodrz5dx5QAIUKY31STF8';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var article;
  bool _isFavorite = false;
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
      appBar: AppBar(
        title: TextField(
          style: GoogleFonts.notoSerif(
              color: Theme.of(context).primaryTextTheme.headline1.color,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          cursorColor: Theme.of(context).primaryTextTheme.headline1.color,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )),
            icon: Icon(Icons.article_rounded,
                color: Theme.of(context).primaryTextTheme.headline1.color),
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
          return Card(
            elevation: 16,
            child: InkWell(
              onTap: () {
                setState(() {
                  lia.launchInApp(article['docs'][index]['web_url']);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: [
                    Container(
                      color: Colors.black54,
                      child: Text(
                        (article['docs'][index]['abstract']),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSerif(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      article['docs'][index]['lead_paragraph'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          color: _isFavorite
                              ? Colors.red
                              : Theme.of(context).textTheme.headline2.color,
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                        ),
                        Text(
                          ('${article['docs'][index]['pub_date']}')
                              .substring(0, 10),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline2.color,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
