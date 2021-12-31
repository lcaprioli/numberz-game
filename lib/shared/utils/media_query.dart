import 'package:flutter/material.dart';
import 'package:numbers/board/board_consts.dart';

class MediaQueryUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 540;
  static double tileSize(context) => isMobile(context)
      ? BoardConsts.mobileTileSize
      : BoardConsts.desktopTileSize;

  static double paddingSize(context) => isMobile(context)
      ? BoardConsts.mobileGridPadding
      : BoardConsts.desktopGridPadding;

  static double columnWidth(context) =>
      tileSize(context) + paddingSize(context);

  static double columnHeight(context) =>
      tileSize(context) * BoardConsts.height +
      (BoardConsts.height * paddingSize(context));
}
