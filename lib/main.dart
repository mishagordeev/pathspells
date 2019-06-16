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
              title: Text("Pathfinder Spells",
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFebe4b1)),
              ),
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
                child: LoadAndShowData()
                //child: Text("test"),
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
            .loadString('assets/path_spells.json'),
        builder: (context, snapshot) {
          spells = parseJson(snapshot.data.toString());
          //print(snapshot.data.toString());
          return spells.isNotEmpty
              ? new SpellList(spell: spells,)
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
  //final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
  //return parsed.map<Spell>((json) => new Spell.fromJson(json)).toList();
  final List parsed = json.decode(response);
  if (parsed == null) return [];
      else return parsed.map<Spell>((json) => new Spell.fromJson(json)).toList();
  //return parsed.map<Spell>((json) => new Spell.fromJson(json)).toList();

}

class Spell {
  final String name;
  final String description;
  final String fullDescription;

  Spell({this.name, this.description, this.fullDescription});

  //Spell.fromJson(Map<String, dynamic> json)
  //    : name = json['name'],
  //      description = json['description'],
  //      fullDescription = json['full_description'];
  factory Spell.fromJson(Map<String, dynamic> json) {
    return new Spell(
        name: json['name'] as String, description: json['description'] as String, fullDescription: json['full_description'] as String);
  }
  //Map<String, dynamic> toJson() =>
  //    {
  //      'name': name,
  //      'email': description,
  //      'full_description': fullDescription,
  //    };
}

/*class SpellList {
  final List<Spell> spells;

  SpellList({
    this.spells,
  });

  factory SpellList.fromJson(List<dynamic> parsedJson) {

    List<Spell> spells = new List<Spell>();

    return new SpellList(
      spells: spells,
    );
  }
}*/


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
                _printTest(spell[index],context);
                if (spell[index].fullDescription.contains('Школа')) {
                  //print("школа");
                }
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
              title: Text(test.name,
                style: TextStyle(color: Color(0xFFebe4b1)),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: SpellCard(test.fullDescription)
              //child: SingleChildScrollView(
              //  child: Description(test.fullDescription),
              //)
            )
          );
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
      spellCardSpanParts.add(new TextSpan(text: description.substring(0, i),
          style: TextStyle(color: Colors.black)));
      print(description.length);
      print(description);
      print(description[i]);
      description = description.substring(i, description.length);
      print(description.length);
      if (description.startsWith('<t')) {
        int endIndex = description.indexOf('</t>');
        spellCardParts.add(RichText(text: TextSpan(children: spellCardSpanParts)));
        spellCardSpanParts = [];
        List<String> tableElements = description.substring(4, endIndex).split(",");
        spellCardParts.add(new GridView.builder(
            physics: ScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true,
            itemCount: tableElements.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 5.0,
              crossAxisSpacing: 3,
              crossAxisCount: int.parse(description[2]),
            ),
            itemBuilder: (BuildContext context, int index) {
              return new Text(tableElements[index]);
            }));
        int j = description.indexOf('</t>');
        print(description);
        description = description.substring(j + 4, description.length);
        print(description);
      }
      //int index = description.indexOf('</t>');
      //print(description.substring(3,index));

      //i = -1;
      //}
      if (description.startsWith('<b>')) {
        int index = description.indexOf('</b>');
        print(description.substring(3, index));
        spellCardSpanParts.add(new TextSpan(
            text: description.substring(3, index),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold)));
        description = description.substring(index + 4, description.length);
        print(description);
      }
      if (description.startsWith('<i>')) {
        int index = description.indexOf('</i>');
        print(description.substring(3, index));
        spellCardSpanParts.add(new TextSpan(
            text: description.substring(3, index),
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)));
        description = description.substring(index + 4, description.length);
        print(description);
      }
      i = description.indexOf('<');
    }
    print(description);
    spellCardSpanParts.add(new TextSpan(text: description, style: TextStyle(color: Colors.black)));
    spellCardParts.add(RichText(text: TextSpan(children: spellCardSpanParts)));
    return new ListView(
        children: (
          spellCardParts
        )
    );
  }
}
      //i = -1;
      //}
      //spellCardSpanParts.add(new TextSpan(text: description, style: TextStyle(color: Colors.black)));
      //print(description.replaceRange(i, i+1, ''));
      //print(i);
      //print(description.substring(0,i));


class Description extends StatelessWidget {
  List<TextSpan> textSpell = [];
  final String _fullDescription;
  Description(this._fullDescription);

  @override
  Widget build(BuildContext context) {
    String blankText = "";
    String boldText = "";
    int i=0;
    while (i<_fullDescription.length) {
      if (_fullDescription[i] == ">") {
        textSpell.add(new TextSpan(text: blankText, style: TextStyle(color: Colors.black)));
        blankText = "";
        i++;
        while (_fullDescription[i] != "<") {
         boldText += _fullDescription[i];
         i++;
        }
        textSpell.add(new TextSpan(text: boldText, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
        boldText = "";
        i++;
      }
      blankText += _fullDescription[i];
      i++;
    }
    textSpell.add(new TextSpan(text: blankText, style: TextStyle(color: Colors.black)));
    return new RichText(
      text: TextSpan(
        children: textSpell),
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
