import 'package:flutter/material.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellSearch.dart';
import 'package:pathspells_flutter/Json.dart';
import 'package:pathspells_flutter/Class.dart';
import 'package:pathspells_flutter/ClassList.dart';
import 'package:pathspells_flutter/ClassListView.dart';
import 'SpellList.dart';
import 'ExternalData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          DefaultAssetBundle.of(context).loadString('assets/classes.json'),
          DefaultAssetBundle.of(context)
              .loadString('assets/path_spells_eng.json')
        ]).then(
          (response) =>
              new ExternalData(classes: response[0], spells: response[1]),
        ),
        builder: (context, AsyncSnapshot<ExternalData> snapshot) {
          var references = Json().parse(snapshot?.data?.spells?.toString());
          var referencesClasses =
              Json().parse(snapshot?.data?.classes?.toString());
          List<Spell> spells = SpellList().get(references);
          List<Class> classes = ClassList().get(referencesClasses);
          return spells.isNotEmpty && classes.isNotEmpty
              ? new MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primaryColor: Colors.red[900],
                    hintColor: Colors.white70,
                    cursorColor: Colors.white,
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
                                showSearch(
                                    context: context,
                                    delegate: SpellSearch(spells));
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.help_outline,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        body: ClassListView(spells, classes)),
                  ),
                )
              : new MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primaryColor: Colors.red[900],
                    hintColor: Colors.white70,
                    cursorColor: Colors.white,
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
                                showSearch(
                                    context: context,
                                    delegate: SpellSearch(spells));
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.help_outline,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        body: Center(
                            child: new CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.red[900]),
                        ))),
                  ),
                );
        });
  }
}
