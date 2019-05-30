import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
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
                      .loadString('assets/dnd_spells.json'),
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

  Country({this.name, this.flag});

  factory Country.fromJson(Map<String, dynamic> json) {
    return new Country(
        name: json['Spell Name'] as String, flag: json['Duration'] as String);
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
          return new ListTile(
              title: Text(country[index].name),
              subtitle: Text(country[index].flag),
              onTap: () {
                _printTest(country[index],context);
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );*/
              });
        });
  }

  void _printTest(Country test, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {

          return Scaffold(
            appBar: AppBar(
              title: Text(test.name),
            ),
            body: Text(test.flag),
          );
        },
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        //child: RaisedButton(
        ////  onPressed: () {
        //    // Navigate back to first route when tapped.
        //  },
        //  child: Text('Go back!'),
        //),
      ),
    );
  }
}
