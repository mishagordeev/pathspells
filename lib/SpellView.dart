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

    /*int i = description.indexOf('<');
    while (i != -1) {
      spellViewSpanParts.add(new TextSpan(
          text: description.substring(0, i),
          style: TextStyle(color: Colors.black)));
      description = description.substring(i, description.length);

      if (description.startsWith('<t')) {
        int endIndex = description.indexOf('</t>');
        spellViewParts
            .add(RichText(text: TextSpan(children: spellViewSpanParts)));
        spellViewSpanParts = [];
        List<String> tableElements =
        description.substring(4, endIndex).split(",");
        final int columnNumber = int.parse(description[2]);
        spellViewParts.add(new GridView.builder(
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
        spellViewSpanParts.add(new TextSpan(
            text: description.substring(3, index),
            style:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
        description = description.substring(index + 4, description.length);
      }

      if (description.startsWith('<i>')) {
        int index = description.indexOf('</i>');
        spellViewSpanParts.add(new TextSpan(
            text: description.substring(3, index),
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)));
        description = description.substring(index + 4, description.length);
      }
      i = description.indexOf('<');
    }*/
    //spellViewSpanParts.add(
    //    new TextSpan(text: description, style: TextStyle(color: Colors.black)));
    spellViewParts.add(RichText(text: TextSpan(children: spellViewSpanParts)));
    return new ListView(children: (spellViewParts));

  }
}