import 'package:flutter/material.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellCard.dart';

class SpellList extends StatelessWidget {
  final List<Spell> spells;
  SpellList({Key key, this.spells}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: SpellCard(spell.fullDescription)));
        },
      ),
    );
  }
}