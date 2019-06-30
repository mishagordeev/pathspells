import 'package:flutter/material.dart';
import 'Spell.dart';
import 'SpellList.dart';

class SpellSearch extends SearchDelegate {
  List<Spell> spells;
  List<Spell> searchSuggestions;

  SpellSearch(this.spells);

  @override
  List<Widget> buildActions(BuildContext context) {
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
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(

    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchSuggestions = [];
    for (int i = 0; i < spells.length; i++) {
      if (spells[i].name.toLowerCase().contains(query.toLowerCase())) {
        searchSuggestions.add(spells[i]);
      }
    }
    return new SpellList(spells: searchSuggestions);
  }
}