import 'package:flutter/material.dart';
import 'dart:convert';
String wer;
List<String> spells = <String>['Absorb', 'Bomb', 'Cast Out1111'];
List<String> gopa = <String>[];
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Builder (
        builder: (context) => Scaffold(
          appBar: AppBar(
              title: Text("Pathfinder Spells"),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: WelSearch(),
                      );
                    }
                )
              ]
          ),
          body: Center(
            child: StateFul(1),
          ),
        ),)
      );
  }
}

class WelSearch extends SearchDelegate {
 // WelSearch(List<String> spells);

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
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
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];

    if (query == '') {
      print(gopa);
      return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: spells.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: Center(child: Text('Entry ${spells[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );} else
      {
          gopa = [];
          for (var i = 0; i<spells.length;i++) {
            if (spells[i].contains(query)) {
              gopa.add(spells[i]);
              print(spells[i]);
            }
          }
          //prbint(spells);
        print(gopa);
        return ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: gopa.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              //color: Colors.amber[colorCodes[index]],
              child: Center(child: Text('Entry ${gopa[index]}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      }
  }

}

void OutputTest() {
  print("success");
}

class SearchBatState extends State<SearchBar> {
  String _govno1;
  SearchBatState(String g) {
    print(g);
  }
  @override
  Widget build(BuildContext context) {
    String _test;
    //SearchBatState("dfgdfg");
    return Text(
      'Hello, $wer, How are you?',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  int Test() {
    print('sddsf');
  }

  void OutputTest() {
    print("success");
  }
}

class SearchBar extends StatefulWidget {
  String _govno;

  SearchBar(String t) {
    _govno = t;
    wer = _govno;
    print('govno' + _govno + ' ');
    print('t' + t + ' ');
  }
  @override
  SearchBatState createState() {
    return SearchBatState(_govno);
  }
}


class RestStateFul extends State<StateFul> {
  RestStateFul(int i);

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: Center(child: Text('Entry ${entries[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class StateFul extends StatefulWidget {
  StateFul(int i);

  @override
  RestStateFul createState() => RestStateFul(123);
}