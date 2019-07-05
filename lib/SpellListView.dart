import 'package:flutter/material.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellCard.dart';

class SpellListView extends StatelessWidget {
  final List<Spell> spells;
  final String characterClass;
  final String level;

  SpellListView(this.spells, this.characterClass, this.level);

  @override
  Widget build(BuildContext context) {
    List <Spell> _spells;

    if (characterClass != null && level != null) {
      _spells = filterSpellList(spells, characterClass, level);
    }
    else
      _spells = spells;

    return new ListView.separated(
        itemCount: _spells == null ? 0 : _spells.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
              title: Text(_spells[index].name),
              subtitle: Text(_spells[index].description),
              onTap: () {
                _showSpellCard(_spells[index], context);
              });
        });
  }

  List<Spell> filterSpellList(
      List<Spell> spells, String characterClass, String level) {
    List<Spell> filteredSpellList = [];
    int itemCount = spells.length;
    for (int i = 0; i < itemCount; i++) {
      if (spells[i].classLevel[characterClass] == level) {
        filteredSpellList.add(spells[i]);
      }
    }
    return filteredSpellList;
  }

  void _showSpellCard(Spell spell, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  spell.name,
                ),
              ),
              body: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
                  child: SpellCard(spell.fullDescription)));
        },
      ),
    );
  }
}
