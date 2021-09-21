import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/board/models/tile_model.dart';

import '../board_consts.dart';

class Tile extends StatelessWidget {
  const Tile({
    required this.tile,
  });

  final TileModel tile;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: tile.key,
      height: 50,
      width: 50,
      margin: EdgeInsets.all(5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: ClipOval(
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: tile.hasHit
                        ? Colors.black
                        : tile.burned
                            ? Colors.black
                            : BoardConsts.tileColors.elementAt(tile.number - 1),
                  ),
                ),
                Visibility(
                  visible: !tile.burned,
                  child: Positioned(
                    top: -5,
                    right: 0,
                    width: 66,
                    height: 66,
                    child: Container(
                      transform: Matrix4.skewX(.02),
                      child: ClipOval(
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.1),
                            BlendMode.screen,
                          ),
                          child: Container(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: FittedBox(
                    child: Text(
                      '${tile.disposed ? '' : tile.number}',
                      style: GoogleFonts.gfsNeohellenic(
                        textStyle: TextStyle(
                          color: tile.hasHit
                              ? Colors.amber
                              : BoardConsts.fontColors.elementAt(tile.number - 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 36.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(
                      color: Color(0xFF3a0d05),
                      width: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
