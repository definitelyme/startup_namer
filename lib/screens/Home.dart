import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _suggestions = <WordPair>[];

  // The Set stores the word pairings that the user favors
  // Set is preferred to list because a properly implemented set does not allow duplicate entries
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 15.0);

  void _navigateFavorites() {
    var route = MaterialPageRoute<void>(builder: (BuildContext context) {
      final tiles = _saved.map((pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });

      final divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
        ),
        body: ListView(
          children: divided,
        ),
      );
    });

    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Namer"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _navigateFavorites,
          )
        ],
      ),
      body: _buildSuggesstions(),
    );
  }

  Widget _buildSuggesstions() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return Divider();
        /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    // add an _alreadySaved check to ensure that a word pairing has not already been added to favorites
    final bool _alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // Add a function to enable clicking
        setState(() {
          // Change the state of the favorite Icon based on _alreadySaved condition
          if (_alreadySaved)
            _saved.remove(pair);
          else
            _saved.add(pair);
        });
      },
    );
  }
}
