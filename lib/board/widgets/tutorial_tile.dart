import 'package:flutter/material.dart';
import 'package:numbers/board/models/tutorial_tile_model.dart';
import 'package:numbers/shared/utils/media_query.dart';

import '../board_consts.dart';
import 'tutorial_touch_icon.dart';

class TutorialTile extends StatefulWidget {
  TutorialTile({
    required this.tile,
    required this.index,
    this.hasPointer = false,
  });

  final TutorialTileModel tile;
  final bool hasPointer;
  final int index;

  @override
  _TutorialTileState createState() => _TutorialTileState();
}

class _TutorialTileState extends State<TutorialTile> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: (widget.index * MediaQueryUtils.tileSize(context)) +
          widget.index * MediaQueryUtils.paddingSize(context),
      child: Opacity(
        opacity: widget.tile.opaque ? 1 : .20,
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
                      color: BoardConsts.tileColors
                          .elementAt(widget.tile.number - 1),
                    ),
                  ),
                  Positioned(
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
                  Center(
                    child: FittedBox(
                      child: Text(
                        '${widget.tile.number}',
                        style: TextStyle(
                          color: BoardConsts.fontColors
                              .elementAt(widget.tile.number - 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
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
                  Visibility(
                    visible: widget.hasPointer,
                    child: Center(
                      child: TutorialTouchIcon(),
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
