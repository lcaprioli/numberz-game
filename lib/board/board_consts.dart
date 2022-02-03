import 'package:flutter/material.dart';

class BoardConsts {
  static const width = 5;
  static const height = 5;

  static const desktopTileSize = 70.0;
  static const mobileTileSize = 45.0;
  static const desktopGridPadding = 10.0;
  static const mobileGridPadding = 5.0;

  final levelScale = 5;
  final timeGap = 10;
  final gameTime = 60;
  final bonusGap = 12;

  final sequenceBonus = 4;
  final matchScore = 10;
  final sequenceBonusScore = 100;
  final sequenceScore = 30;

  static Set<Color> tileColors = {
    Color(0xffef9d1e),
    Color(0xffd75509),
    Color(0xff4e0501),
    Color(0xff39261c),
    Color(0xff47403d),
  };

  static List<Color> fontColors = [
    Color(0xff3a0d05),
    Color(0xffe8cfbc),
    Color(0xfff5d268),
    Color(0xfff7935c),
    Colors.white,
  ];
}
