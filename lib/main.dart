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
                    List<Spell> spells =
                        parseJosn(snapshot.data.toString());
                    return !spells.isEmpty
                        ? new SpellList(spell: spells)
                        : new Center(child: new CircularProgressIndicator());
                  }),
            ),
          )),
    );
  }
}

List<Spell> parseJosn(String response) {
  if (response == null) {
    return [];
  }
  final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
  return parsed.map<Spell>((json) => new Spell.fromJson(json)).toList();
}

class Spell {
  final String name;
  final String flag;

  Spell({this.name, this.flag});

  factory Spell.fromJson(Map<String, dynamic> json) {
    return new Spell(
        name: json['Spell Name'] as String, flag: json['Duration'] as String);
  }
}

class SpellList extends StatelessWidget {
  final List<Spell> spell;
  SpellList({Key key, this.spell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: spell == null ? 0 : spell.length,
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
              title: Text(spell[index].name),
              subtitle: Text(spell[index].flag),
              onTap: () {
                _printTest(spell[index],context);
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );*/
              });
        });
  }

  void _printTest(Spell test, BuildContext context) {
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
