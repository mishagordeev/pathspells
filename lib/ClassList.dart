import 'package:pathspells_flutter/Class.dart';

class ClassList {

  List<Class> get(List jsonData) {
    return jsonData.map<Class>((json) {
      return new Class.get(json);
    }).toList();
  }
}