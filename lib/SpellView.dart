import 'package:flutter/material.dart';

class SpellView extends StatelessWidget {
  final String description;
  final String notes;
  final bool legal;

  SpellView(this.description, this.notes, this.legal);

  @override
  Widget build(BuildContext context) {
    List<Widget> spellViewParts = [];
    List<TextSpan> spellViewSpanParts = [];
    int i = 0;
    String descriptionPart = "";

    void addCaption(String string) {
      if (spellViewSpanParts != []) {
        spellViewParts
            .add(RichText(text: TextSpan(children: spellViewSpanParts)));
        spellViewSpanParts = [];
      }
      spellViewParts.add(new Container(
        color: Colors.red[900].withOpacity(0.9),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(string, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                padding: EdgeInsets.only(left: 3),
              ),
            )
          ],
        ),
      ));
    }

    void addNotLegalLabel() {
      if (notes != '') {
        spellViewSpanParts.add(new TextSpan(
            text: "Not Pathfinder Society legal.\n", style: TextStyle(color: Colors.black)));

      } else {
        spellViewSpanParts.add(new TextSpan(
            text: "Not Pathfinder Society legal.\n\n",
            style: TextStyle(color: Colors.black)));
      }
    }

    void addSubhead(String string) {
      spellViewSpanParts.add(new TextSpan(
          text: string, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)));
    }

    void addNotes(String string) {
      spellViewSpanParts.add(new TextSpan(
          text: string + "\n\n", style: TextStyle(color: Colors.black)));
    }

    void addBlankText(String string) {
      spellViewSpanParts.add(
          new TextSpan(text: string, style: TextStyle(color: Colors.black)));
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

      List<TableRow> rows = [];
      List<Widget> elements = [];
      int i = 0;
      while (i!=tableElements.length) {
        if (i < columnNumber) {
          elements.add(Text(tableElements[i],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),));
        } else
        elements.add(Text(tableElements[i],textAlign: TextAlign.center,));
        i++;
        if (i % columnNumber == 0) {
          rows.add(TableRow(children: elements));
          elements = [];
        }
      }

      spellViewParts.add(Table(
        border: TableBorder(bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1.0),horizontalInside: BorderSide(color: Theme.of(context).dividerColor, width: 1.0)),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: rows,
      ));
    }
    if (!legal) {
      addNotLegalLabel();
    }
    if (notes != '') {
      addNotes(notes);
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
        if (description[i] == 'c') {
          i++;
          while (description[i] != '>') {
            descriptionPart += description[i];
            i++;
          }
          addCaption(descriptionPart);
          descriptionPart = "";
        }
        if (description[i] == 'v') {
          i++;
          while (description[i] != '>') {
            descriptionPart += description[i];
            i++;
          }
          addSubhead(descriptionPart);
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
    return new Column(

        children: (spellViewParts));
       // padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0));
  }
}
