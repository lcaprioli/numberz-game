import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/board/models/tile_model.dart';

import '../board_consts.dart';

class Tile extends StatefulWidget {
  Tile({
    required this.tile,
    required this.index,
    required this.isMobile,
  });

  final TileModel tile;
  final int index;
  final bool isMobile;

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeInOutCubicEmphasized,
      duration: const Duration(milliseconds: 1200),
      key: widget.tile.customKey,
      bottom: (widget.index *
              (widget.isMobile
                  ? BoardConsts.mobileTileSize
                  : BoardConsts.desktopTileSize)) +
          widget.index *
              (widget.isMobile
                  ? BoardConsts.mobileGridPadding
                  : BoardConsts.desktopGridPadding),
      child: SizedBox(
        height: (widget.isMobile
            ? BoardConsts.mobileTileSize
            : BoardConsts.desktopTileSize),
        width: (widget.isMobile
            ? BoardConsts.mobileTileSize
            : BoardConsts.desktopTileSize),
        child: ClipOval(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: widget.tile.hasHit
                        ? Colors.black
                        : widget.tile.burned
                            ? Colors.black
                            : BoardConsts.tileColors
                                .elementAt(widget.tile.number - 1),
                  ),
                ),
                Visibility(
                  visible: !widget.tile.burned,
                  child: Positioned(
                    top: -(widget.isMobile
                            ? BoardConsts.mobileTileSize
                            : BoardConsts.desktopTileSize) /
                        12,
                    right: 0,
                    width: (widget.isMobile
                            ? BoardConsts.mobileTileSize
                            : BoardConsts.desktopTileSize) *
                        .87,
                    height: (widget.isMobile
                            ? BoardConsts.mobileTileSize
                            : BoardConsts.desktopTileSize) *
                        .87,
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
                  child: Visibility(
                    visible: !widget.tile.disposed,
                    child: FittedBox(
                      child: Text(
                        '${widget.tile.disposed ? '' : widget.tile.number}',
                        style: GoogleFonts.gfsNeohellenic(
                          textStyle: TextStyle(
                            color: widget.tile.hasHit
                                ? Colors.amber
                                : BoardConsts.fontColors
                                    .elementAt(widget.tile.number - 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 36.0,
                          ),
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
