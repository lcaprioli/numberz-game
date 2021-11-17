import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/board/widgets/sound_button.dart';
import 'package:numbers/board/widgets/tile.dart';
import 'package:numbers/shared/templates/main_body.dart';

import 'models/tile_model.dart';
import 'widgets/clock.dart';
import 'board_consts.dart';
import 'board_controller.dart';
import 'widgets/decoration.dart';
import 'widgets/score.dart';

class BoardScreen extends StatefulWidget {
  BoardScreen({
    Key? key,
    required this.title,
    required this.isMobile,
  }) : super(key: key);

  final String title;
  final bool isMobile;

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late BoardController controller;

  late Timer _timer;

  late AudioCache audioCache;
  AudioPlayer? musicPlayer;

  bool _clockAlarm = false;

  @override
  void initState() {
    audioCache = AudioCache(prefix: "assets/audio/");

    int _width =
        widget.isMobile ? BoardConsts.mobileWidth : BoardConsts.desktopWidth;

    int _height =
        widget.isMobile ? BoardConsts.mobileHeight : BoardConsts.desktopHeight;
    controller = BoardController(
      _width,
      _height,
      audioCache: audioCache,
      //     updateScreen: _updateScreen,
      /* stateAction: (List<Point> points) {
        for (var i = 0; i < points.length; i++) {
          setState(() {
            controller.columns[points[i].x][points[i].y].disposed = true;
          });
          setState(() {
            controller.columns[points[i].x].add(TileModel(
              customKey: GlobalKey(),
              number: Random().nextInt(999),
              point: Point(i, 0),
            ));
            controller.columns[points[i].x].removeAt(points[i].y);
            for (var a = points[i].y; a < controller.columns[points[i].x].length; a++) {
              controller.columns[points[i].x][a].point.y =
                  controller.columns[points[i].x][a].point.y - 1;
            }
          });
        }
      }, */
    );
    /*    for (var i = 0; i < _width; i++) {
      GlobalKey<AnimatedListState> ckey = GlobalKey<AnimatedListState>();
      _listState.add(ckey);
    }
  */
    controller.setInitial();

    /*  _refresh = Timer.periodic(Duration(milliseconds: 150), (t) {
       setState(() {
        controller.moveDown(t);
      });
 
      _clockAlarm = !_clockAlarm;
    });*/
    /*s _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
           if (controller.totalTime > 0) {
        controller.reduceTimer();
      } else {
        if (bestScore < controller.score) {
          bestScore = controller.score;
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => GameOver(
              score: controller.score,
              bestScore: bestScore,
            ),
          ),
        );
        _timer.cancel();
      }
    }); */

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    //_refresh.cancel();
    super.dispose();
  }

/*   Widget _tileitem(int column, int row, int index) {
    TileModel item = controller.columns[column].value[row];
    return Tile(
      tile: item,
      index: index,
    );
  }
 */
  /*  void _updateScreen() {
    setState(() {
      controller.columns = controller.columns;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return MainBody(
      content: Expanded(
        child: Stack(
          children: [
            Flex(
              direction: widget.isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: (controller.height) * 85,
                          width: (controller.width) * 85,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.all(15),
                          child: Listener(
                            onPointerMove: controller.pointerDown,
                            onPointerUp: controller.pointerUp,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(controller.columns.length,
                                  (columnIndex) {
                                return Container(
                                  height: (BoardConsts.tileSize *
                                          controller.height) +
                                      ((controller.height) * 5),
                                  width: BoardConsts.tileSize + 5,
                                  child: Stack(
                                    children: List.generate(
                                      controller
                                          .columns[columnIndex].value.length,
                                      (index) => ValueListenableBuilder<
                                              List<TileModel>>(
                                          valueListenable:
                                              controller.columns[columnIndex],
                                          builder: (_, list, __) {
                                            return Tile(
                                              tile: list[index],
                                              index: index,
                                            );
                                          }),
                                    ),
                                  ),
                                ); /* [
                                Container(
                                  margin: EdgeInsets.all(15),
                                  width: 50,
                                  height: (controller.height * 2) * 50,
                                  color: Colors.green,
                                ),
                              ],
                            */
                              }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: widget.isMobile ? 1 : 4,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 40,
                      right: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Opacity(
                          opacity: controller.bonusTime > 0 && _clockAlarm
                              ? .5
                              : 1.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Clock(
                                counter: controller.totalTime,
                                amount: BoardConsts().gameTime,
                                title: 'Time left',
                                color: Colors.yellow,
                              ),
                              Clock(
                                counter: controller.burnTime,
                                amount: BoardConsts().timeGap,
                                title: 'Burn',
                                color: Color(0xffd75509),
                              ),
                            ],
                          ),
                        ),
                        Score(
                          controller.score,
                          widget.isMobile,
                        ),
                        Visibility(
                          visible: !widget.isMobile,
                          child: ChiefDecoration(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SoundButton(
                  onTap: () async {
                    if (musicPlayer == null) {
                      musicPlayer = await audioCache.loop("music.mp3");

                      setState(() {
                        controller.isMuted = false;
                      });
                    } else {
                      if (musicPlayer?.state == PlayerState.PLAYING) {
                        musicPlayer?.pause();

                        setState(() {
                          controller.isMuted = true;
                        });
                      } else {
                        musicPlayer?.resume();

                        setState(() {
                          controller.isMuted = false;
                        });
                      }
                    }
                  },
                  isMuted: controller.isMuted,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /*  Widget _buildFadeAndSizeTransitioningTile({
    required Animation<double> anim,
    required int column,
    required int row,
  }) {
    return FadeTransition(
      opacity: anim,
      child: SizeTransition(
        sizeFactor: anim,
        axisAlignment: 0.0,
        child: _tileitem(column, row),
      ),
    );
  } */
}
