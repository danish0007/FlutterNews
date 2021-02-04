import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:exam1/components/launch_in_app.dart';
import 'package:exam1/components/app_bar_title.dart';
import 'package:exam1/components/publish_date_cell.dart';

const String Apikey = 'iPTJBfr8mJhrodrz5dx5QAIUKY31STF8';

class WorldScreen extends StatefulWidget {
  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  var article;
  bool _isFavorite = false;
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
      appBar: AppBar(
        title: AppBarTitle("World"),
      ),
      body: article != null
          ? ListView.builder(
              itemCount: article != null ? article.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 16,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        lia.launchInApp(article[index]['url']);
                      });
                    },
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            Container(
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    article[index]['multimedia'][0]['url']),
                              )),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  article[index]['title'],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.notoSerif(
                                      fontSize: 24,
                                      color: Colors.white,
                                      backgroundColor: Colors.black87),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              article[index]['abstract'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(fontSize: 24),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  color: _isFavorite
                                      ? Colors.red
                                      : Theme.of(context)
                                          .textTheme
                                          .headline2
                                          .color,
                                  icon: Icon(Icons.favorite),
                                  onPressed: () {
                                    setState(() {
                                      _isFavorite = !_isFavorite;
                                    });
                                  },
                                ),
                                PublishDateCell(
                                  article: article,
                                  index: index,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).accentColor,
            )),
    );
  }
}
