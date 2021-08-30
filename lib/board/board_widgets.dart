import 'package:flutter/material.dart';

import 'board_consts.dart';
import 'board_tile_model.dart';

class BoardWidgets {
  AnimatedContainer buildTile(Tile tile, BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: tile.hasHit
            ? Colors.black
            : tile.burned
                ? Colors.black
                : BoardConsts.tileColors.elementAt(tile.number - 1),
        borderRadius: BorderRadius.circular(45),
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      key: tile.key,
      duration: Duration(milliseconds: 250),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Text(
            '${tile.disposed ? '' : tile.number}',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: tile.hasHit ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
