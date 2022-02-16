import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexcolor) {
    hexcolor = hexcolor.toUpperCase().replaceAll("#", "");
    if (hexcolor.length == 6) {
      hexcolor = "FF" + hexcolor;
    }
    return int.parse(hexcolor, radix: 16);
  }

  HexColor(final String hexcolor) : super(_getColorFromHex(hexcolor));
}