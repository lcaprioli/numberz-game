import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/board/models/tile_model.dart';

import '../board_consts.dart';

class Tile extends StatefulWidget {
  Tile({
    required this.tile,
  });

  final TileModel tile;

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  double _burnStep = 0.0;

  @override
  Widget build(BuildContext context) {
    if (widget.tile.burned) {
      _burnStep = _burnStep + 0.25;
    } else {
      _burnStep = 0.0;
    }
    return Container(
      key: widget.tile.key,
      height: 50,
      width: 50,
      margin: EdgeInsets.all(5),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 355),
        opacity: widget.tile.burned ? 0.25 : 1,
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
      ),
    );
  }
}
