import 'package:flutter/material.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/SpellView.dart';

class SpellListTestView extends StatelessWidget {
  final List<Spell> spells;
  final String characterClass;
  final int level;

  SpellListTestView(this.spells, this.characterClass, this.level);

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
          return new Container(
            child: Column(
              children: <Widget>[
                Text(_spells[index].name),
                Text(_spells[index].fullDescription)
              ],
            )
          );
        });
  }

  List<Spell> _filterSpellList(
      List<Spell> spells, String characterClass, int level) {
    List<Spell> filteredSpellList = [];
    int itemCount = spells.length;
    List alpha = ['A','B','C','D','E','F','G','H','I','J','K','L',
      'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

    if (characterClass == "alltext") {
      for (int i = 0; i < itemCount; i++) {
        if (spells[i].name[0] == alpha[level]) {
          filteredSpellList.add(spells[i]);
        }
      }
      return filteredSpellList;
    }

    for (int i = 0; i < itemCount; i++) {
      if (spells[i].level[characterClass] == level) {
        filteredSpellList.add(spells[i]);
      }
    }
    return filteredSpellList;
  }

  Widget CaptionAttribute(String attribute) {
    return Container(
      padding: EdgeInsets.all(0.5),
      child: Container(
        height: 26,
        child: Text(attribute, textAlign: TextAlign.left,style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _setAppBarAttributes(List<dynamic> attributes) {
    List<Widget> _attributes = [];
    for (var x in attributes) {
      switch (x) {
        case 'F':
          _attributes.add(CaptionAttribute("F"));
          break;
        case 'M':
          _attributes.add(CaptionAttribute("M"));
          break;
        case 'R':
          _attributes.add(CaptionAttribute("R"));
          break;
        case 'T':
          _attributes.add(CaptionAttribute("T"));
          break;
        case 'Y':
          _attributes.add(CaptionAttribute("Y"));
          break;
      }
    }
    return Row(
      children: _attributes,
    );
  }

  Widget LabelAttributes(String attribute) {
    return Container(
      padding: EdgeInsets.all(0.5),
      child: Container(
        height: 22,
        child: Text(attribute, textAlign: TextAlign.left,style: TextStyle(color: Colors.red[900].withOpacity(0.5), fontSize: 12)),
      ),
    );
  }

  Widget _setAttributes(List<dynamic> attributes) {
    List<Widget> _attributes = [];
    for (var x in attributes) {
      switch (x) {
        case 'F':
          _attributes.add(LabelAttributes("F"));
          break;
        case 'M':
          _attributes.add(LabelAttributes("M"));
          break;
        case 'R':
          _attributes.add(LabelAttributes("R"));
          break;
        case 'T':
          _attributes.add(LabelAttributes("T"));
          break;
        case 'Y':
          _attributes.add(LabelAttributes("Y"));
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
          if (spell.attributes.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: <Widget>[
                    Text(spell.name, softWrap: true,),
                    _setAppBarAttributes(spell.attributes)
                  ],
                ),
              ),
              body: SpellView(spell.fullDescription,spell.notes,spell.legal),
            );
          } else
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  spell.name, softWrap: true,
                ),
              ),
              body: SpellView(spell.fullDescription,spell.notes,spell.legal),
            );
        },
      ),
    );
  }
}
