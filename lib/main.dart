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
                              onPressed: () {
                                _showInfo(context);
                              },
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
                              onPressed: () {
                                _showInfo(context);
                              },
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

  _showInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "About"
              ),
            ),
            body: infoView()
          );
        },
      ),
    );
  }

  Widget infoView() {
    return ListView(
      children: <Widget>[
        RichText(text: TextSpan(
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: "This app uses trademarks and/or copyrights owned by Paizo Inc., which are used under Paizo's Community Use Policy. We are expressly prohibited from charging you to use or access this content. This app is not published, endorsed, or specifically approved by Paizo Inc. For more information about Paizo's Community Use Policy, please visit paizo.com/communityuse. For more information about Paizo Inc. and Paizo products, please visit paizo.com.\n\n"
              ),
              TextSpan(
                text: "All spells ate taken from Archives of Nethys website aonprd.com. Thank Blake Davis for his great work!\n\n"
              ),
              TextSpan(
                text: " F ",
                style: TextStyle(backgroundColor: Colors.red[900].withOpacity(0.5), color: Colors.white),
              ),
              TextSpan(
                  text: " – this spell has a focus component not normally included in a spell component pouch.\n",
              ),
              TextSpan(
                text: " M ",
                style: TextStyle(backgroundColor: Colors.red[900].withOpacity(0.5), color: Colors.white),
              ),
              TextSpan(
                  text: " – this spell has a material component not normally included in a spell component pouch.\n",
              ),
              TextSpan(
                text: " R ",
                style: TextStyle(backgroundColor: Colors.red[900].withOpacity(0.5), color: Colors.white),
              ),
              TextSpan(
                  text: " – spell requires a requisite religion or race. If religion, spellcaster must worship the listed deity to utilize the spell. If race, the spell might only target members of the listed race (the spell will say this if it does), but often are just the race's guarded secrets. Members of other races can learn to cast them with GM permission.\n",
              ),
              TextSpan(
                text: " T ",
                style: TextStyle(backgroundColor: Colors.red[900].withOpacity(0.5), color: Colors.white),
              ),
              TextSpan(
                  text: " – in order to prepare any of these spells, the caster must spend an hour performing a ritual in which he beseeches Torag (or a member of his family) for the aid of one of his divine family members. For 24 hours after the ritual, the caster may prepare spells of the requested deity. The caster may only attune himself to one additional deity at a time.\n",
              ),
              TextSpan(
                text: " Y ",
                style: TextStyle(backgroundColor: Colors.red[900].withOpacity(0.5), color: Colors.white),
              ),
              TextSpan(
                  text: " – this spell has a Mythic version.",
              )
            ]
        ))
      ],
      padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
    );
  }
}
