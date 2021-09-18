import 'package:flutter/material.dart';

class BoardConsts {
  static const mobileWidth = 5;
  static const mobileHeight = 6;
  static const desktopWidth = 11;
  static const desktopHeight = 5;

  final levelScale = 5;
  final timeGap = 20;
  final gameTime = 120;
  final bonusGap = 12;

  final sequenceBonus = 3;
  final matchScore = 10;
  final sequenceBonusScore = 200;
  final sequenceScore = 50;

  static Set<Color> tileColors = {
    Color(0xfffede5f),
    Color(0xffd64915),
    Color(0xffe36825),
    Color(0xffb88251),
    Color(0xff927777),
  };
}
