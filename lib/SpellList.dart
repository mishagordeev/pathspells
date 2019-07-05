import 'package:pathspells_flutter/Spell.dart';

class SpellList {

  List<Spell> get(List jsonData) {
    return jsonData.map<Spell>((json) {
      return new Spell.get(json);
    }).toList();
  }
}