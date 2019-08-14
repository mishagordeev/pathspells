import 'package:flutter/material.dart';
import 'package:pathspells_flutter/SpellListView.dart';
import 'package:pathspells_flutter/Spell.dart';
import 'package:pathspells_flutter/Class.dart';
import 'package:pathspells_flutter/SpellListTestView.dart';

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
                  _showClassSpells(context, classes[index].id, classes[index].levelCount, classes[index].name,classes[index].hasNotZeroLevel);
                });
          })
    );
  }

  void _showClassSpells(BuildContext context, String characterClass, int levelCount, String className, bool hasNotZeroLevel) {
    List<Widget> tabs = [];
    List<Widget> tabsView = [];
    List<String> endingNumerals = ['','st','nd','rd','th','th','th','th','th','th','th',
      'th','th','th','th','th','th','th','th','th','th','th','th','th','th','th'];
    List<String> alpha = ['A','B','C','D','E','F','G','H','I','J','K','L',
      'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

    int startIndex;
    int length;
    if (hasNotZeroLevel) {
      startIndex = 1;
      length = levelCount - 1;
    } else {
      startIndex = 0;
      length = levelCount;
    }
    if (characterClass == "alltext") {
      for (int i = startIndex; i < levelCount; i++) {
        tabs.add(Tab(child: Text(alpha[i],style: TextStyle(fontSize: 16),),));
        tabsView.add(SpellListTestView(spells, characterClass, i));
      }
    } else {
    for (int i = startIndex; i < levelCount; i++) {
      if (characterClass == "alpha") {
        tabs.add(Tab(child: Text(alpha[i],style: TextStyle(fontSize: 16),),));
      } else
      tabs.add(Tab(child: Text(i.toString() + endingNumerals[i] + "-" + "Level",style: TextStyle(fontSize: 16),),));
      tabsView.add(SpellListView(spells, characterClass, i));
    }}


    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return DefaultTabController(
              length: length,
              child: Scaffold(
                appBar: AppBar(
                    title: Text(className),
                    bottom: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.white,
                        tabs: tabs,
                    ),
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
