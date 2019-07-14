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
              child: Text("Not\nPFS\nlegal",textAlign: TextAlign.center,style: TextStyle(color: Colors.red[900].withOpacity(0.5),fontSize: 12)),
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

  Widget CaptionAttribute(String attribute) {
    return Container(
      padding: EdgeInsets.all(1.5),
      child: Container(
        width: 24,
        height: 24,
        color: Colors.white,
        child: Text(attribute,textAlign: TextAlign.center,style: TextStyle(color: Colors.red[900])),
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
      padding: EdgeInsets.all(1.5),
      child: Container(
        width: 18,
        height: 18,
        color: Colors.red[900].withOpacity(0.7),
        child: Text(attribute, textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
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
                    Text(spell.name),
                    _setAppBarAttributes(spell.attributes)
                  ],
                ),
              ),
              body: SpellView(spell.fullDescription,spell.notes),
            );
          } else
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
