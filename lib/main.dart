import 'package:flutter/material.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellSearch.dart';
import 'package:pathspells_flutter/Json.dart';
import 'package:pathspells_flutter/Class.dart';
import 'package:pathspells_flutter/ClassList.dart';
import 'package:pathspells_flutter/ClassListView.dart';

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
                      .loadString('assets/classes.json'),
                  builder: (context, snapshot) {
                    var references = Json().parse(snapshot.data.toString());
                    List<Class> classes = ClassList().get(references);
                    return classes.isNotEmpty
                        ? new ClassListView([], classes)
                        : new Center(child: new CircularProgressIndicator(
                      backgroundColor: Colors.red[900],
                    ));
                  })
            ),
      ),
    );
  }
}