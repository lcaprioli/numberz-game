import 'package:flutter/material.dart';
import 'package:numbers/board/board_consts.dart';

class MediaQueryUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 540;
  static double desktopTileSize(BuildContext context) =>
      (BoardConsts.desktopTileSize / 800) * MediaQuery.of(context).size.height;
}
