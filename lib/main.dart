import 'package:flutter/material.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellSearch.dart';
import 'package:pathspells_flutter/Json.dart';
import 'package:pathspells_flutter/Class.dart';
import 'package:pathspells_flutter/ClassList.dart';
import 'package:pathspells_flutter/ClassListView.dart';
import 'SpellList.dart';
import 'SpellListView.dart';
import 'ExternalData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  List<Spell> spells;

  @override
  Widget build(BuildContext context) {
    //Future<String> spel = ;
    //Future<String> clas = DefaultAssetBundle.of(context).loadString('assets/classes.json');
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
                  future: Future.wait([
                    DefaultAssetBundle.of(context).loadString('assets/classes.json'),
                    DefaultAssetBundle.of(context).loadString('assets/path_spells_eng.json')]).then(
                          (response) => new ExternalData(classes:response[0],spells: response[1]),
                  ),
                  //future: DefaultAssetBundle.of(context)
                  //    .loadString('assets/path_spells_eng.json'),
                  builder: (context, AsyncSnapshot<ExternalData>snapshot) {
                    print(snapshot.data.spells);
                    var references = Json().parse(snapshot.data.spells.toString());
                    var referencesClasses = Json().parse(snapshot.data.classes.toString());
                    print(references);
                    List<Spell> spells = SpellList().get(references);
                    List<Class> classes = ClassList().get(referencesClasses);
                    print(spells);
                    return spells.isNotEmpty && classes.isNotEmpty
                        ? new ClassListView(spells,classes)
                        : new Center(child: new CircularProgressIndicator(

                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red[900]),
                    ));
                  })
            ),
      ),
    );
  }
}