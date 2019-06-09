import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(MyApp());

List<Spell> spells;

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF3d0800),
      ),
      home: Builder (
        builder: (context) => Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    semanticLabel: 'search',
                  ),
                  onPressed: () {
                    print('Search button');
                    showSearch(
                        context: context,
                        delegate: SpellSearch()
                    );
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
                child: new LoadAndShowData(),
              ),
            )),
      ),
    );
  }
}


class LoadAndShowData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/dnd_spells.json'),
        builder: (context, snapshot) {
          spells = parseJson(snapshot.data.toString());
          return spells.isNotEmpty
              ? new SpellList(spell: spells)
              : new Center(child: new CircularProgressIndicator());
        });
  }
}


class SpellSearch extends SearchDelegate {
  List<Spell> _searchSuggestions;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _searchSuggestions = [];
    for (int i = 0;i<spells.length;i++) {
      if (spells[i].name.contains(query)) {
        _searchSuggestions.add(spells[i]);
      }
    }
    return new SpellList(spell: _searchSuggestions);
  }
}

List<Spell> parseJson(String response) {
  if (response == null) {
    return [];
  }
  final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
  return parsed.map<Spell>((json) => new Spell.fromJson(json)).toList();
}

class Spell {
  final String name;
  final String description;
  final String duration;

  Spell({this.name, this.description, this.duration});

  factory Spell.fromJson(Map<String, dynamic> json) {
    return new Spell(
        name: json['Spell Name'] as String, description: json['Components'] as String, duration: json['Duration'] as String);
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
              subtitle: Text(spell[index].description),
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
            body: Text(test.description),
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
