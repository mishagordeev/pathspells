import 'package:flutter/material.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellView.dart';

class SpellListView extends StatelessWidget {
  final List<Spell> spells;
  final String characterClass;
  final String level;

  SpellListView(this.spells, this.characterClass, this.level);

  @override
  Widget build(BuildContext context) {
    List <Spell> _spells;

    if (characterClass != null && level != null) {
      _spells = _filterSpellList(spells, characterClass, level);
    }
    else
      _spells = spells;

    return new ListView.separated(
        itemCount: _spells == null ? 0 : _spells.length,
        separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          if (_spells[index].attributes.isNotEmpty) {
            return new Container(
              child: ListTile(
                  isThreeLine: true,
                  title: Row(
                    children: [
                      Text(_spells[index].name),
                      Row(
                        children: _setAttributes(_spells[index].attributes),
                      )
                    ]
                  ),
                  subtitle: Text(_spells[index].description),
                  onTap: () {
                    _showSpellView(_spells[index], context);
                  }),
            );
          } else {
            return new Container(
              child: ListTile(
                  isThreeLine: true,
                  title: Text(_spells[index].name),
                  subtitle: Text(_spells[index].description),
                  onTap: () {
                    _showSpellView(_spells[index], context);
                  }),
            );
          }
        });
  }

  List<Spell> _filterSpellList(
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

  List <Widget> _setAttributes(List<dynamic> attributes) {
    List<Widget> _attributes = [];
    for (var x in attributes) {
      switch (x) {
        case 'F':
          _attributes.add(Image.asset("assets/icons/f.png"));
          break;
        case 'M':
          _attributes.add(Image.asset("assets/icons/m.png"));
          break;
        case 'R':
          _attributes.add(Image.asset("assets/icons/r.png"));
          break;
        case 'T':
          _attributes.add(Image.asset("assets/icons/t.png"));
          break;
        case 'Y':
          _attributes.add(Image.asset("assets/icons/y.png"));
          break;
      }
    }
    return _attributes;
  }

  void _showSpellView(Spell spell, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  spell.name,
                ),
              ),
              body: SpellView(spell.fullDescription),
          );
        },
      ),
    );
  }
}
