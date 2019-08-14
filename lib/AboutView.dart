import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        RichText(
            text: TextSpan(style: TextStyle(color: Colors.black), children: [
              TextSpan(
                  text:
                  "This app uses trademarks and/or copyrights owned by Paizo Inc., which are used under Paizo's Community Use Policy. We are expressly prohibited from charging you to use or access this content. This app is not published, endorsed, or specifically approved by Paizo Inc. For more information about Paizo's Community Use Policy, please visit "),
              TextSpan(
                  text: "paizo.com/communityuse",
                  style: TextStyle(
                      color: Colors.red[900], decoration: TextDecoration.underline,),

                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch('https:paizo.com/communityuse');
                    }),
              TextSpan(
                  text:
                  ". For more information about Paizo Inc. and Paizo products, please visit "),
              TextSpan(
                  text: "paizo.com",
                  style: TextStyle(
                    color: Colors.red[900], decoration: TextDecoration.underline,),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch('https://paizo.com');
                    }),
              TextSpan(text: ".\n\n"),
              TextSpan(text: "All spells are taken from "),
              TextSpan(
                  text: "Archives of Nethys",
                  style: TextStyle(
                    color: Colors.red[900], decoration: TextDecoration.underline,),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch('https://aonprd.com');
                    }),
              TextSpan(text: " website. Thank Blake Davis for his great work!\n\n"),
              TextSpan(text: "Send all suggestions and all founded bugs to my "),
              TextSpan(
                  text: "e-mail",
                  style: TextStyle(
                    color: Colors.red[900], decoration: TextDecoration.underline,),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch('mailto:mishagordeev@gmail.com');
                    }),
              TextSpan(text: " or discord misha#6189.\n\n"),
              TextSpan(
                text: " F",
                style: TextStyle(
                    color: Colors.red[900].withOpacity(0.9)),
              ),
              TextSpan(
                text:
                " – this spell has a focus component not normally included in a spell component pouch.\n",
              ),
              TextSpan(
                text: "M",
                style: TextStyle(
                    color: Colors.red[900].withOpacity(0.9)),
              ),
              TextSpan(
                text:
                " – this spell has a material component not normally included in a spell component pouch.\n",
              ),
              TextSpan(
                text: "R",
                style: TextStyle(
                    color: Colors.red[900].withOpacity(0.9)),
              ),
              TextSpan(
                text:
                " – spell requires a requisite religion or race. If religion, spellcaster must worship the listed deity to utilize the spell. If race, the spell might only target members of the listed race (the spell will say this if it does), but often are just the race's guarded secrets. Members of other races can learn to cast them with GM permission.\n",
              ),
              TextSpan(
                text: "T",
                style: TextStyle(
                    color: Colors.red[900].withOpacity(0.9)),
              ),
              TextSpan(
                text:
                " – in order to prepare any of these spells, the caster must spend an hour performing a ritual in which he beseeches Torag (or a member of his family) for the aid of one of his divine family members. For 24 hours after the ritual, the caster may prepare spells of the requested deity. The caster may only attune himself to one additional deity at a time.\n",
              ),
              TextSpan(
                text: "Y",
                style: TextStyle(
                    color: Colors.red[900].withOpacity(0.9)),
              ),
              TextSpan(
                text: " – this spell has a Mythic version.\n",
              )
            ])),
      ],
      padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
    );
  }

}