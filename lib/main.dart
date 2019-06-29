import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(MyApp());

List<Spell> spells;
bool circle0 = false;
String dropdownValue;
String dropdownValue1;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.pink[900],
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Pathfinder Spells",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: SpellSearch());
                },
              ),
            ],
          ),
          body: new Container(
            child: new Center(child: LoadAndShowData()),
          ),
        ),
      ),
    );
  }
}

class LoadAndShowData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/path_spells.json'),
        builder: (context, snapshot) {
          spells = parseJson(snapshot.data.toString());
          return spells.isNotEmpty
              ? new SpellList(
            spell: spells,
          )
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
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(

    );
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
    for (int i = 0; i < spells.length; i++) {
      if (spells[i].name.toLowerCase().contains(query.toLowerCase())) {
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
  final List parsed = json.decode(response);
  if (parsed == null)
    return [];
  else
    return parsed.map<Spell>((json) => new Spell.fromJson(json)).toList();
}

class Spell {
  final String name;
  final String description;
  final String fullDescription;

  Spell({this.name, this.description, this.fullDescription});

  factory Spell.fromJson(Map<String, dynamic> json) {
    return new Spell(
        name: json['name'] as String,
        description: json['description'] as String,
        fullDescription: json['full_description'] as String);
  }
}

class SpellList extends StatelessWidget {
  final List<Spell> spell;
  SpellList({Key key, this.spell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.separated(
        itemCount: spell == null ? 0 : spell.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
              title: Text(spell[index].name),
              subtitle: Text(spell[index].description),
              onTap: () {
                _printTest(spell[index], context);
              });
        });
  }

  void _printTest(Spell test, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  test.name,
                ),
              ),
              body: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: SpellCard(test.fullDescription)));
        },
      ),
    );
  }
}

class SpellCard extends StatelessWidget {
  String description;

  SpellCard(this.description);

  final List<Widget> spellCardParts = [];
  List<TextSpan> spellCardSpanParts = [];

  @override
  Widget build(BuildContext context) {
    int i = description.indexOf('<');
    while (i != -1) {
      spellCardSpanParts.add(new TextSpan(
          text: description.substring(0, i),
          style: TextStyle(color: Colors.black)));
      description = description.substring(i, description.length);
      if (description.startsWith('<t')) {
        int endIndex = description.indexOf('</t>');
        spellCardParts
            .add(RichText(text: TextSpan(children: spellCardSpanParts)));
        spellCardSpanParts = [];
        List<String> tableElements =
        description.substring(4, endIndex).split(",");
        final int columnNumber = int.parse(description[2]);
        spellCardParts.add(new GridView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: tableElements.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 5.0,
              crossAxisSpacing: 0,
              crossAxisCount: columnNumber,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index < columnNumber) if (index % columnNumber == 0)
                return new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 2.0))),
                    child: Text(tableElements[index],
                        style: TextStyle(fontWeight: FontWeight.bold)));
              else
                return new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 2.0))),
                    child: Text(tableElements[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center));
              if (index >= columnNumber) if (index % columnNumber == 0)
                return new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Theme.of(context).dividerColor))),
                    child: Text(tableElements[index]));
              else
                return new Container(
                  decoration: new BoxDecoration(
                      border: new Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child:
                  Text(tableElements[index], textAlign: TextAlign.center),
                );
            }));
        int j = description.indexOf('</t>');
        description = description.substring(j + 4, description.length);
      }
      if (description.startsWith('<b>')) {
        int index = description.indexOf('</b>');
        spellCardSpanParts.add(new TextSpan(
            text: description.substring(3, index),
            style:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
        description = description.substring(index + 4, description.length);
      }
      if (description.startsWith('<i>')) {
        int index = description.indexOf('</i>');
        spellCardSpanParts.add(new TextSpan(
            text: description.substring(3, index),
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)));
        description = description.substring(index + 4, description.length);
      }
      i = description.indexOf('<');
    }
    spellCardSpanParts.add(
        new TextSpan(text: description, style: TextStyle(color: Colors.black)));
    spellCardParts.add(RichText(text: TextSpan(children: spellCardSpanParts)));
    return new ListView(children: (spellCardParts));
  }
}
