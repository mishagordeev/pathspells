import 'package:flutter/material.dart';
import 'dart:convert';
String wer;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: SearchBar('Misha'),
        ),
        body: Center(
          child: StateFul(1),
        ),
      ),
    );
  }
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