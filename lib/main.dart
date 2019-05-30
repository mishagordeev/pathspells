import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.brown,
      ),
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                semanticLabel: 'menu',
              ),
              onPressed: () {
                print('Menu button');
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  semanticLabel: 'search',
                ),
                onPressed: () {
                  print('Search button');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.tune,
                  semanticLabel: 'filter',
                ),
                onPressed: () {
                  print('Filter button');
                },
              ),
            ],
          ),
          body: new Container(
            child: new Center(
              // Use future builder and DefaultAssetBundle to load the local JSON file
              child: new FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/spells.json'),
                  builder: (context, snapshot) {
                    List<Country> countries =
                        parseJosn(snapshot.data.toString());
                    return !countries.isEmpty
                        ? new CountyList(country: countries)
                        : new Center(child: new CircularProgressIndicator());
                  }),
            ),
          )),
    );
  }
}

List<Country> parseJosn(String response) {
  if (response == null) {
    return [];
  }
  final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
  return parsed.map<Country>((json) => new Country.fromJson(json)).toList();
}

class Country {
  final String name;
  final String flag;
  final String capital;

  Country({this.name, this.flag, this.capital});

  factory Country.fromJson(Map<String, dynamic> json) {
    return new Country(
      name: json['name'] as String,
      flag: json['description'] as String
    );
  }
}

class CountyList extends StatelessWidget {
  final List<Country> country;
  CountyList({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: country == null ? 0 : country.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Container(
              child: new Center(
                  child: new Column(
                // Stretch the cards in horizontal axis
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Text(
                    // Read the name field value and set it in the Text widget
                    country[index].name,
                    // set some style to text
                    //style: new TextStyle(
                    //   fontSize: 20.0, color: Colors.lightBlueAccent),
                  ),
                  new Text(
                    // Read the name field value and set it in the Text widget
                    country[index].flag,
                    // set some style to text
                    //style: new TextStyle(fontSize: 20.0, color: Colors.amber),
                  ),
                ],
              )),
              padding: const EdgeInsets.all(15.0),
            ),
          );
        });
  }
}
