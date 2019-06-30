import 'package:flutter/material.dart';
import 'package:pathspells_flutter/SpellList.dart';
import 'package:pathspells_flutter/Spell.dart';

class ClassList extends StatelessWidget {
  final List<Spell> spells;
  ClassList(this.spells);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Divider(height: 5),
          ListTile(
            leading: Image.asset('assets/images/bard.png'),
            title: Text("Бард"),
            onTap: () {
              showClassSpells(context,"bard",7,"Бард");
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/mage.png'),
            title: Text("Волшебник"),
            onTap: () {
              showClassSpells(context,"wizard",10,"Волшебник");
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/cleric.png'),
            title: Text("Жрец"),
            onTap: () {
              showClassSpells(context,"cleric",10,"Жрец");
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/druid.png'),
            title: Text("Друид"),
            onTap: () {
              showClassSpells(context,"druid",10,"Друид");
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/paladin.png'),
            title: Text("Паладин"),
            onTap: () {
              showClassSpells(context,"paladin",5,"Паладин");
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/ranger.png'),
            title: Text("Следопыт"),
            onTap: () {
              showClassSpells(context,"ranger",5,"Следопыт");
            },
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/wizard.png'),
            title: Text("Чародей"),
            onTap: () {
              showClassSpells(context,"wizard",10,"Чародей");
            },
          ),
          Divider(),
        ],
      )
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
