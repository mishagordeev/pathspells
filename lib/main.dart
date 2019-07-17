import 'package:flutter/material.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellSearch.dart';
import 'package:pathspells_flutter/Json.dart';
import 'package:pathspells_flutter/Class.dart';
import 'package:pathspells_flutter/ClassList.dart';
import 'package:pathspells_flutter/ClassListView.dart';
import 'SpellList.dart';
import 'ExternalData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  String out = "";

  Future<String> loadAsset() async {
    String g = await rootBundle.loadString('assets/1.txt');
    int i = 0;
    String spell = "";
    String level = "";
    String output = "";
    String description = "";
    i = g.indexOf("<s");
    //i = -1;
    while (i != -1) {
      i++;
      i++;
      while (g[i] != ">") {
        spell += g[i];
        //print(spell);
        i++;
      }
      i++;
      g = g.substring(i,g.length);
      /*while (g[i] != "}") {
        description += g[i];
        i++;
      }*/

      //print(spell);

      i = g.indexOf("<bL")+3;
      while (g[i] != "<") {
        level += g[i];
        i++;
      }
      output = "{";
      List<String> classes= ["adept","alchemist","antipaladin","arcanist","bard","bloodrager","cleric","druid","hunter","inquisitor","investigator","magus","medium","mesmerist","occultist","oracle","paladin","psychic","ranger","red mantis assassin","sahir-afiyun","shaman","skald","sorcerer","spiritualist","summoner","summoner (unchained)","warpriest","witch","wizard"];
      classes.forEach((element) {
        if (level.contains(element)) output += "\"" + element + "\"" + " : " + level[level.indexOf(element)+element.length+1] + ", ";
      }  );
      output = output.substring(0, output.length-2);
      output += "}";
      level = "";
      print(spell + "|" + output);
      spell = "";
      description = "";

      //g = g.substring(i,g.length);
      i = g.indexOf("<s");
    }
  }

  @override
  Widget build(BuildContext context) {
    loadAsset();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.red[900],
          hintColor: Colors.white70,
          cursorColor: Colors.white,
          textSelectionColor: Colors.red,
          accentColor: Colors.red[900]
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
                    //showSearch(
                    //context: context,
                    //delegate: SpellSearch(spells));
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
            body: ListView(
              children: <Widget>[
                TextField()
              ],
            )
        ),
      ),
    );
  }

  _showInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text("About"),
              ),
              body: infoView());
        },
      ),
    );
  }

  Widget infoView() {
    return ListView(
      children: <Widget>[
        RichText(
            text: TextSpan(style: TextStyle(color: Colors.black), children: [
              TextSpan(
                  text:
                  "   This app uses trademarks and/or copyrights owned by Paizo Inc., which are used under Paizo's Community Use Policy. We are expressly prohibited from charging you to use or access this content. This app is not published, endorsed, or specifically approved by Paizo Inc. For more information about Paizo's Community Use Policy, please visit "),
              TextSpan(
                  text: "paizo.com/communityuse",
                  style: TextStyle(
                      color: Colors.red[900], fontWeight: FontWeight.bold),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch('https:paizo.com/communityuse');
                    }),
              TextSpan(
                  text:
                  ". For more information about Paizo Inc. and Paizo products, please visit "),
              TextSpan(
                  text: "paizo.com",
                  style: TextStyle(
                      color: Colors.red[900], fontWeight: FontWeight.bold),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch('https://paizo.com');
                    }),
              TextSpan(text: ".\n\n"),
              TextSpan(text: "   All spells are taken from "),
              TextSpan(
                  text: "Archives of Nethys",
                  style: TextStyle(
                      color: Colors.red[900], fontWeight: FontWeight.bold),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch('https://aonprd.com');
                    }),
              TextSpan(text: " website. Thank Blake Davis for his great work!\n\n"),
              TextSpan(
                text: " F ",
                style: TextStyle(
                    backgroundColor: Colors.red[900].withOpacity(0.7),
                    color: Colors.white,
                    letterSpacing: 0.8),
              ),
              TextSpan(
                text:
                " – this spell has a focus component not normally included in a spell component pouch.\n",
              ),
              TextSpan(
                text: " M ",
                style: TextStyle(
                    backgroundColor: Colors.red[900].withOpacity(0.7),
                    color: Colors.white,
                    letterSpacing: -0.5),
              ),
              TextSpan(
                text:
                " – this spell has a material component not normally included in a spell component pouch.\n",
              ),
              TextSpan(
                text: " R ",
                style: TextStyle(
                    backgroundColor: Colors.red[900].withOpacity(0.7),
                    color: Colors.white,
                    letterSpacing: 0.6),
              ),
              TextSpan(
                text:
                " – spell requires a requisite religion or race. If religion, spellcaster must worship the listed deity to utilize the spell. If race, the spell might only target members of the listed race (the spell will say this if it does), but often are just the race's guarded secrets. Members of other races can learn to cast them with GM permission.\n",
              ),
              TextSpan(
                text: " T ",
                style: TextStyle(
                    backgroundColor: Colors.red[900].withOpacity(0.7),
                    color: Colors.white,
                    letterSpacing: 0.6),
              ),
              TextSpan(
                text:
                " – in order to prepare any of these spells, the caster must spend an hour performing a ritual in which he beseeches Torag (or a member of his family) for the aid of one of his divine family members. For 24 hours after the ritual, the caster may prepare spells of the requested deity. The caster may only attune himself to one additional deity at a time.\n",
              ),
              TextSpan(
                text: " Y ",
                style: TextStyle(
                    backgroundColor: Colors.red[900].withOpacity(0.7),
                    color: Colors.white,
                    letterSpacing: 0.6),
              ),
              TextSpan(
                text: " – this spell has a Mythic version.\n",
              )
            ])),
      ],
      padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
    );
  }
}
