import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellSearch.dart';
import 'package:pathspells_flutter/ClassList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  List<Spell> spells;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red[900],
        hintColor: Colors.white70,
        //accentColor: Colors.red,
        //backgroundColor: Colors.red,
        //bottomAppBarColor: Colors.red,
        //buttonColor: Colors.red,
        //canvasColor: Colors.red,
        //cardColor: Colors.red,
        cursorColor: Colors.white,
        //disabledColor: Colors.red,
        //dividerColor: Colors.red,
        //dialogBackgroundColor: Colors.red,
        //errorColor: Colors.red,

        //highlightColor: Colors.red,
        //indicatorColor: Colors.red,
        //primaryColorLight: Colors.red,
        //primaryColorDark: Colors.red,
        textSelectionColor: Colors.red,




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
                      showSearch(context: context, delegate: SpellSearch(spells));
                    },
                  ),
                ],
              ),
              body: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/path_spells.json'),
                  builder: (context, snapshot) {
                    spells = parseJson(snapshot.data.toString());
                    return spells.isNotEmpty
                        ? new ClassList(spells)
                        : new Center(child: new CircularProgressIndicator(
                      backgroundColor: Colors.red[900],
                    ));
                  })
            ),
      ),
    );
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
}