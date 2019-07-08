import 'package:flutter/material.dart';
import 'package:pathspells_flutter/SpellListView.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/Class.dart';

class ClassListView extends StatelessWidget {
  final List<Class> classes;
  final List<Spell> spells;

  ClassListView(this.spells, this.classes);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
          itemCount: classes == null ? 0 : classes.length,
          separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
          itemBuilder: (BuildContext context, int index) {
            return new ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                leading: Image.asset(classes[index].image),
                title: Text(classes[index].name),
                onTap: () {
                  _showClassSpells(context, classes[index].id, classes[index].levelCount, classes[index].name);
                });
          })
    );
  }

  void _showClassSpells(BuildContext context, String characterClass, int levelCount, String className) {
    List<Widget> tabs = [];
    List<Widget> tabsView = [];
    List<String> endingNumerals = ['','st','nd','rd','th','th','th','th','th','th'];

    for (int i = 0; i < levelCount; i++) {
      tabs.add(Tab(text: i.toString() + endingNumerals[i] + "-" + "Level"));
      tabsView.add(SpellListView(spells, characterClass, i.toString()));
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
                        tabs: tabs,
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.filter_list,
                        ),
                        onPressed: () {

                        },
                      )
                    ],
                ),

                body: TabBarView(
                  children: tabsView,
                ),
              ));
        },
      ),
    );
  }
}
