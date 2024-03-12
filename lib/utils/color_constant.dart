import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color promptSearchColor = fromHex('#6363A7').withOpacity(0.3);
  static Color promptSearchBorderColor = fromHex('#6F6FC8');

  static Color ideaPromptIconColor = fromHex('#EDEDFF').withOpacity(0.3);
  static Color ideaPromptColor = fromHex('#3B3B4E').withOpacity(0.3);
  static Color ideaPromptIconBackColor = fromHex('#3B3B4E').withOpacity(0.6);

  static Color dropdown = fromHex('#282635');

  static Color bottomNavEdit = fromHex('#282635');

  static Color ideaIconColor = fromHex('#626272');

  static Color ideaColor60 = fromHex('#3B3B4E4D').withOpacity(0.6);

  static Color ideaColor30 = fromHex('#3B3B4E4D').withOpacity(0.3);
  static Color textColour = fromHex('#99ececff');

  static Color texth1 = fromHex('#8E91F4');

  static Color soundColor = fromHex('#EDEDFF');

  static Color floatingActionBtnColor = fromHex('#6F6FC8');
  static Color searchBar = fromHex('#3B3B4E');

  static Color gray1004c = fromHex('#4cf5edfe');

  static Color red900 = fromHex('#b52510');

  static Color indigo504c = fromHex('#4cececff');

  static Color red300 = fromHex('#ed6a6a');

  static Color blueGray80099 = fromHex('#993b3b4e');

  static Color blueGray80075 = fromHex('#753b3b4e');

  static Color blueGray8004c01 = fromHex('#4c3b3b4d');

  static Color black900 = fromHex('#000000');

  static Color lightBlueA700 = fromHex('#0079fb');

  static Color blueGray800 = fromHex('#1c3857');

  static Color blueGray900 = fromHex('#2e2e3d');

  static Color gray600 = fromHex('#676974');

  static Color blueGray100 = fromHex('#ced8e3');

  static Color indigo50 = fromHex('#ececff');

  static Color blueGray600 = fromHex('#5f5e80');

  static Color gray900 = fromHex('#1f1d2b');

  static Color blueGray500 = fromHex('#5d7289');

  static Color red30001 = fromHex('#ed6969');

  static Color gray90001 = fromHex('#232330');

  static Color blueGray80001 = fromHex('#3b3b4d');

  static Color orange300 = fromHex('#ffbf47');

  static Color gray100 = fromHex('#f5edfe');

  static Color indigo400 = fromHex('#6e6ec7');

  static Color bluegray400 = fromHex('#888888');

  static Color gray10001 = fromHex('#f7f7f7');

  static Color indigo5099 = fromHex('#99ececff');

  static Color whiteA700 = fromHex('#ffffff');

  static Color blueGray8004c = fromHex('#4c3b3b4e');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
