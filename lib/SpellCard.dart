import 'package:flutter/material.dart';

class SpellCard extends StatelessWidget {
  String description;

  SpellCard(this.description);

  final List<Widget> spellCardParts = [];
  List<TextSpan> spellCardSpanParts = [];

  @override
  Widget build(BuildContext context) {
    int i = description.indexOf('<');
    while (i != -1) {
      spellCardSpanParts.add(new TextSpan(
          text: description.substring(0, i),
          style: TextStyle(color: Colors.black)));
      description = description.substring(i, description.length);
      if (description.startsWith('<t')) {
        int endIndex = description.indexOf('</t>');
        spellCardParts
            .add(RichText(text: TextSpan(children: spellCardSpanParts)));
        spellCardSpanParts = [];
        List<String> tableElements =
        description.substring(4, endIndex).split(",");
        final int columnNumber = int.parse(description[2]);
        spellCardParts.add(new GridView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: tableElements.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 5.0,
              crossAxisSpacing: 0,
              crossAxisCount: columnNumber,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index < columnNumber) if (index % columnNumber == 0)
                return new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 2.0))),
                    child: Text(tableElements[index],
                        style: TextStyle(fontWeight: FontWeight.bold)));
              else
                return new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 2.0))),
                    child: Text(tableElements[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center));
              if (index >= columnNumber) if (index % columnNumber == 0)
                return new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Theme.of(context).dividerColor))),
                    child: Text(tableElements[index]));
              else
                return new Container(
                  decoration: new BoxDecoration(
                      border: new Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child:
                  Text(tableElements[index], textAlign: TextAlign.center),
                );
            }));
        int j = description.indexOf('</t>');
        description = description.substring(j + 4, description.length);
      }
      if (description.startsWith('<b>')) {
        int index = description.indexOf('</b>');
        spellCardSpanParts.add(new TextSpan(
            text: description.substring(3, index),
            style:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
        description = description.substring(index + 4, description.length);
      }
      if (description.startsWith('<i>')) {
        int index = description.indexOf('</i>');
        spellCardSpanParts.add(new TextSpan(
            text: description.substring(3, index),
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)));
        description = description.substring(index + 4, description.length);
      }
      i = description.indexOf('<');
    }
    spellCardSpanParts.add(
        new TextSpan(text: description, style: TextStyle(color: Colors.black)));
    spellCardParts.add(RichText(text: TextSpan(children: spellCardSpanParts)));
    return new ListView(children: (spellCardParts));
  }
}