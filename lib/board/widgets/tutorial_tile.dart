import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/board/models/tutorial_tile_model.dart';
import 'package:numbers/shared/utils/media_query.dart';

import '../board_consts.dart';

class TutorialTile extends StatefulWidget {
  TutorialTile({
    required this.tile,
    required this.index,
    required this.isMobile,
  });

  final TutorialTileModel tile;
  final int index;
  final bool isMobile;

  @override
  _TutorialTileState createState() => _TutorialTileState();
}

class _TutorialTileState extends State<TutorialTile> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeInOutCubicEmphasized,
      duration: const Duration(milliseconds: 1200),
      key: widget.tile.customKey,
      bottom: (widget.index * MediaQueryUtils.tileSize(context)) +
          widget.index * MediaQueryUtils.paddingSize(context),
      child: SizedBox(
        height: MediaQueryUtils.tileSize(context),
        width: MediaQueryUtils.tileSize(context),
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
                    top: -MediaQueryUtils.tileSize(context) / 12,
                    right: 0,
                    width: MediaQueryUtils.tileSize(context) * .87,
                    height: MediaQueryUtils.tileSize(context) * .87,
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
                            fontSize: 26.0,
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
