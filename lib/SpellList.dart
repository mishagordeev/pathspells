import 'package:flutter/material.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellCard.dart';

class SpellList extends StatelessWidget {
  List<Spell> spells;
  final String characterClass;
  final String level;

  SpellList(this.spells, this.characterClass, this.level);

  @override
  Widget build(BuildContext context) {
    if (characterClass != null && level != null) {
      spells = sortSpellList(spells, characterClass, level);
    }
    return new ListView.separated(
        itemCount: spells == null ? 0 : spells.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
              title: Text(spells[index].name),
              subtitle: Text(spells[index].description),
              onTap: () {
                _showSpellCard(spells[index], context);
              });
        });
  }

  List<Spell> sortSpellList(
      List<Spell> spells, String characterClass, String level) {
    List<Spell> sortedSpellList = [];
    int itemCount = spells.length;
    for (int i = 0; i < itemCount; i++) {
      if (spells[i].classLevel[characterClass] == level) {
        sortedSpellList.add(spells[i]);
      }
    }
    return sortedSpellList;
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
