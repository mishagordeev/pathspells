import 'package:flutter/material.dart';

class ClassList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Image.asset('assets/images/mage.png'),
          title: Text("Волшебник"),
          onTap: () {
            _showClassSpells(context);
          },
        )
      ],
    );
  }

  void _showClassSpells(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                    "Волшебник"
                ),
              ),
              body: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: Container(child: Center(child: Text("text"),),)));
        },
      ),
    );
  }
}