import 'package:flutter/material.dart';

class SpellView extends StatelessWidget {
  final String description;

  SpellView(this.description);

  @override
  Widget build(BuildContext context) {
    List<Widget> spellViewParts = [];
    List<TextSpan> spellViewSpanParts = [];
    int i = 0;
    String descriptionPart = "";

    void addBlankText(String string) {
      spellViewSpanParts.add(new TextSpan(
          text: string,
          style: TextStyle(color: Colors.black)));
    }

    void addBoldText(String string) {
      spellViewSpanParts.add(new TextSpan(
          text: string,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
    }

    void addItalicText(String string) {
      spellViewSpanParts.add(new TextSpan(
          text: string,
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic)));
    }

    void addTable(int columnNumber, List<String> tableElements) {
      if (spellViewSpanParts != []) {
        spellViewParts
            .add(RichText(text: TextSpan(children: spellViewSpanParts)));
        spellViewSpanParts = [];
      }
      spellViewParts.add(new GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: tableElements.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 20 / columnNumber,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
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
          })
      );
    }

    while (i != description.length) {
      if (description[i] != '<') {
        descriptionPart += description[i];
      } else {
        addBlankText(descriptionPart);
        descriptionPart = "";
        i++;
        if (description[i] == 'b') {
          i++;
          while (description[i] != '>') {
            descriptionPart += description[i];
            i++;
          }
          addBoldText(descriptionPart);
          descriptionPart = "";
        }
        if (description[i] == 'i') {
          i++;
          while (description[i] != '>') {
            descriptionPart += description[i];
            i++;
          }
          addItalicText(descriptionPart);
          descriptionPart = "";
        }
        if (description[i] == 't') {
          i++;
          int columnNumber = int.parse(description[i]);
          i++;
          while (description[i] != '>') {
            descriptionPart += description[i];
            i++;
          }
          List<String> tableElements = descriptionPart.split(";");
          addTable(columnNumber, tableElements);
          descriptionPart = "";
        }
      }
      i++;
    }
    addBlankText(descriptionPart);
    spellViewParts.add(RichText(text: TextSpan(children: spellViewSpanParts)));
    return new ListView(children: (spellViewParts), padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0));

  }
}