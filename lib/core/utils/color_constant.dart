import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color lightBlueA100 = fromHex('#7bdbfc');
  static Color gray700 = fromHex('#5a5a5a');
  static Color gray5001 = fromHex('#fdedff');

  static Color red800 = fromHex('#bb2929');

  static Color purple90000 = fromHex('#0064236a');

  static Color black9003f = fromHex('#3f000000');

  static Color green600 = fromHex('#2faa50');

  static Color gray50 = fromHex('#fbf6fb');

  static Color black900 = fromHex('#000000');

  static Color purple30001 = fromHex('#b07fb4');

  static Color teal700 = fromHex('#038950');

  static Color gray50001 = fromHex('#919191');

  static Color yellow900 = fromHex('#fa8f21');

  static Color purple900 = fromHex('#65236a');

  static Color gray20001 = fromHex('#ebebeb');

  static Color gray50003 = fromHex('#959595');

  static Color gray50002 = fromHex('#929192');

  static Color purple700 = fromHex('#833d89');

  static Color blueGray900 = fromHex('#353535');

  static Color redA700 = fromHex('#f70000');

  static Color purple300 = fromHex('#bc76c1');

  static Color purple50 = fromHex('#efe2f0');

  static Color black90026 = fromHex('#26000000');

  static Color purple400 = fromHex('#905195');

  static Color gray600 = fromHex('#818181');

  static Color black900A2 = fromHex('#a2000000');

  static Color gray400 = fromHex('#b3b3b3');

  static Color gray500 = fromHex('#939393');

  static Color blueGray100 = fromHex('#d1d1d1');

  static Color blue700 = fromHex('#0c72d1');

  static Color blueGray400 = fromHex('#898989');

  static Color gray800 = fromHex('#414141');

  static Color gray200 = fromHex('#e7e7e7');

  static Color gray40005 = fromHex('#b9b9b9');

  static Color gray40006 = fromHex('#bbbbbb');

  static Color black90033 = fromHex('#33000000');

  static Color gray40001 = fromHex('#b4b4b4');

  static Color gray40002 = fromHex('#c2c2c2');

  static Color bluegray400 = fromHex('#888888');

  static Color gray40003 = fromHex('#c4c4c4');

  static Color purple5001 = fromHex('#efe3f0');

  static Color gray40004 = fromHex('#b7b7b7');

  static Color purple9004c = fromHex('#4c65236a');

  static Color green60002 = fromHex('#2aa24a');

  static Color gray40000 = fromHex('#00c4c4c4');

  static Color black90019 = fromHex('#19000000');

  static Color purple900A2 = fromHex('#a265236a');

  static Color green60001 = fromHex('#34a853');

  static Color whiteA700 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
