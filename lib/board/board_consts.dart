import 'package:flutter/material.dart';

class BoardConsts {
  static const mobileWidth = 4;
  static const mobileHeight = 5;
  static const desktopWidth = 5;
  static const desktopHeight = 5;

  static const desktopTileSize = 70.0;
  static const mobileTileSize = 65.0;
  static const desktopGridPadding = 10.0;
  static const mobileGridPadding = 7.0;

  final levelScale = 5;
  final timeGap = 20;
  final gameTime = 60;
  final bonusGap = 12;

  final sequenceBonus = 3;
  final matchScore = 10;
  final sequenceBonusScore = 200;
  final sequenceScore = 50;

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
