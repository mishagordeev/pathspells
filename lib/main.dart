import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  //Widget build(BuildContext context) {
  //  final wordPair = WordPair.random();
  //  return MaterialApp(
  //    title: 'Startup Name Generator',
  //   theme: ThemeData(
  //      // Add the 3 lines from here...
  //      primaryColor: Colors.white,
  //    ),
  //   home: RandomWords(),
  //  );
  //}
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Welcome to Flutter',
      theme: ThemeData(
        // Add the 3 lines from here...
        primaryColor: Colors.brown,
      ),
      home: Scaffold(
          appBar: AppBar(
            //title: Text('Welcome to Flutter'),
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                semanticLabel: 'menu',
              ),
              onPressed: () {
                print('Menu button');
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  semanticLabel: 'search',
                ),
                onPressed: () {
                  print('Search button');
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
          //body: GridView.count(
          //  crossAxisCount: 2,
          //  padding: EdgeInsets.all(16.0),
          //  childAspectRatio: 8.0 / 9.0,
          //  // TODO: Build a grid of cards (102)
          //  children: <Widget>[Card()],
          //),

          body: ListView(
            children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                      title: Text('Spell 1'),
                      onTap: () {
                        print("test");
                      }
                  )
                ]
            ).toList(),
          )
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final String _pair = "test";
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: Icon(Icons.search), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.black : null,
      ),
      onTap: () {
        // Add 9 lines from here...
        //setState(() {
        //  if (alreadySaved) {
        //    _saved.remove(pair);
        //  } else {
        //    _saved.add(pair);
        //  }
        //});
        _openTile(pair.asPascalCase);
      },
    );
  }

  void _openTile(String test) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          return Scaffold(
            // Add 6 lines from here...
              appBar: AppBar(
                title: Text(test),
              )
          );
        },
      ), // ... to here.
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            // Add 6 lines from here...
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ... to here.
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
