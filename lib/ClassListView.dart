import 'package:flutter/material.dart';
import 'package:pathspells_flutter/SpellList.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/Class.dart';

class ClassListView extends StatelessWidget {
  final List<Class> classes;
  final List<Spell> spells;

  ClassListView(this.spells, this.classes);

  @override
  Widget build(BuildContext context) {

    ListView test = ListView.separated(
        itemCount: classes == null ? 0 : classes.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
              leading: Image.asset(classes[index].image),
              title: Text(classes[index].name),
              onTap: () {
                showClassSpells(context,classes[index].id, classes[index].levelCount,classes[index].name);
              });
        });

    return SafeArea(
      child: ListView.separated(
          itemCount: classes == null ? 0 : classes.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return new ListTile(
                leading: Image.asset(classes[index].image),
                title: Text(classes[index].name),
                onTap: () {
                  showClassSpells(context,classes[index].id, classes[index].levelCount,classes[index].name);
                });
          })
    );
  }

  void showClassSpells(BuildContext context, String characterClass, int levelCount, String className) {
    List<Widget> tabs = [];
    List<Widget> tabsView = [];
    tabs.add(Tab(text: "ФОКУСЫ"));
    tabsView.add(SpellList(spells, characterClass, 0.toString()));

    for (int i = 1; i < levelCount; i++) {
      tabs.add(Tab(text: "$i КРУГ"));
      tabsView.add(SpellList(spells, characterClass, i.toString()));
    }
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return DefaultTabController(
              length: levelCount,
              child: Scaffold(
                appBar: AppBar(
                    title: Text(className),
                    bottom: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.white,
                        tabs: tabs)),
                body: TabBarView(
                  children: tabsView,
                ),
              ));
        },
      ),
    );
  }
}