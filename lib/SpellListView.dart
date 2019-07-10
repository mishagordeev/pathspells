import 'package:flutter/material.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellView.dart';

class SpellListView extends StatelessWidget {
  final List<Spell> spells;
  final String characterClass;
  final int level;

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
          Widget legal;
          List <Widget> title = [Text(_spells[index].name)];

          if (!_spells[index].legal) {
            legal = Container(
              child: Text("not\nPFS\nlegal",textAlign: TextAlign.center,style: TextStyle(color: Colors.red[900].withOpacity(0.3))),
            );
          }
          if (_spells[index].attributes.isNotEmpty) {
            title.add(_setAttributes(_spells[index].attributes));
          }
          return new Container(
            child: ListTile(
                isThreeLine: true,
                title: Row(
                  children: title
                ),
                subtitle: Text(_spells[index].description),
                trailing: legal,
                onTap: () {
                  _showSpellView(_spells[index], context);
                }),
          );
        });
  }

  List<Spell> _filterSpellList(
      List<Spell> spells, String characterClass, int level) {
    List<Spell> filteredSpellList = [];
    int itemCount = spells.length;
    for (int i = 0; i < itemCount; i++) {
      if (spells[i].classLevel[characterClass] == level) {
        filteredSpellList.add(spells[i]);
      }
    }
    return filteredSpellList;
  }

  Widget _setAttributes(List<dynamic> attributes) {
    List<Widget> _attributes = [];
    for (var x in attributes) {
      switch (x) {
        case 'F':
          _attributes.add(
              Container(
                padding: EdgeInsets.all(1),
                child: Container(
                  width: 18,
                  height: 18,
                  color: Colors.red[900].withOpacity(0.6),
                  child: Text("F",textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
                ),
              )
          );
          break;
        case 'M':
          _attributes.add(
              Container(
                padding: EdgeInsets.all(1),
                child: Container(
                  width: 18,
                  height: 18,
                  color: Colors.red[900].withOpacity(0.6),
                  child: Text("M",textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
                ),
              )
          );
          break;
        case 'R':
          _attributes.add(
              Container(
                padding: EdgeInsets.all(1),
                child: Container(
                  width: 18,
                  height: 18,
                  color: Colors.red[900].withOpacity(0.6),
                  child: Text("R",textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
                ),
              )
          );
          break;
        case 'T':
          _attributes.add(
              Container(
                padding: EdgeInsets.all(1),
                child: Container(
                  width: 18,
                  height: 18,
                  color: Colors.red[900].withOpacity(0.6),
                  child: Text("T",textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
                ),
              )
          );
          break;
        case 'Y':
          _attributes.add(
              Container(
                padding: EdgeInsets.all(1),
                child: Container(
                  width: 18,
                  height: 18,
                  color: Colors.red[900].withOpacity(0.6),
                  child: Text("Y",textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
                ),
              )
          );
          break;
      }
    }
    return Row(
      children: _attributes,
    );
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
              body: SpellView(spell.fullDescription,spell.notes),
          );
        },
      ),
    );
  }
}
