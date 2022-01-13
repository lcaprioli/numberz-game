import 'dart:async';

//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/board/widgets/sound_button.dart';
import 'package:numbers/board/widgets/tile.dart';
import 'package:numbers/game_over/game_over.dart';
import 'package:numbers/main.dart';
import 'package:numbers/menu/menu_screen.dart';
import 'package:numbers/shared/templates/main_body.dart';
import 'package:numbers/shared/templates/previous_button.dart';
import 'package:numbers/shared/utils/media_query.dart';

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

  //late AudioCache audioCache;
  //AudioPlayer? musicPlayer;

  bool _clockAlarm = false;

  @override
  void initState() {
    //audioCache = AudioCache(prefix: "assets/audio/");
    controller = BoardController(
      BoardConsts.width,
      BoardConsts.height,
      //audioCache: audioCache,
    );
    controller.setInitial();

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (controller.totalTime.value > 0) {
        controller.reduceTimer();
      } else {
        if (bestScore < controller.score.value) {
          bestScore = controller.score.value;
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => GameOver(
              score: controller.score.value,
              bestScore: bestScore,
            ),
          ),
        );
        _timer.cancel();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      content: Expanded(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Flex(
                direction: widget.isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const MenuScreen()),
                          (route) => false),
                      child: PreviousButton(),
                    ),
                  ),
                  Flexible(
                    flex: MediaQueryUtils.isMobile(context) ? 11 : 4,
                    fit: MediaQueryUtils.isMobile(context)
                        ? FlexFit.loose
                        : FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQueryUtils.isMobile(context) ? 10.0 : 30.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.all(
                                (MediaQueryUtils.isMobile(context)
                                        ? BoardConsts.mobileGridPadding
                                        : BoardConsts.desktopGridPadding) *
                                    2),
                            child: ValueListenableBuilder<bool>(
                                valueListenable: controller.disabled,
                                builder: (_, disable, __) {
                                  return Opacity(
                                    opacity: disable ? .78 : 1,
                                    child: IgnorePointer(
                                      ignoring: disable,
                                      child: Listener(
                                        onPointerMove: controller.pointerDown,
                                        onPointerUp: controller.pointerUp,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              controller.columns.length,
                                              (columnIndex) {
                                            return Container(
                                              height:
                                                  MediaQueryUtils.columnHeight(
                                                      context),
                                              width:
                                                  MediaQueryUtils.columnWidth(
                                                      context),
                                              child: Stack(
                                                children: List.generate(
                                                  controller
                                                      .columns[columnIndex]
                                                      .value
                                                      .length,
                                                  (index) =>
                                                      ValueListenableBuilder<
                                                              List<TileModel>>(
                                                          valueListenable:
                                                              controller
                                                                      .columns[
                                                                  columnIndex],
                                                          builder:
                                                              (_, list, __) {
                                                            return Tile(
                                                              tile: list[index],
                                                              index: index,
                                                              isMobile: widget
                                                                  .isMobile,
                                                            );
                                                          }),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: MediaQueryUtils.isMobile(context) ? 8 : 3,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: widget.isMobile ? 10 : 40,
                        left: 40,
                        right: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Opacity(
                            opacity: controller.bonusTime > 0 && _clockAlarm
                                ? .5
                                : 1.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ValueListenableBuilder<int>(
                                    valueListenable: controller.totalTime,
                                    builder: (_, t, __) {
                                      return Clock(
                                        counter: t,
                                        amount: BoardConsts().gameTime,
                                        title: 'Time left',
                                        color: Colors.yellow.shade800,
                                      );
                                    }),
                                ValueListenableBuilder<int>(
                                    valueListenable: controller.burnTime,
                                    builder: (_, t, __) {
                                      return Clock(
                                        counter: t,
                                        amount: BoardConsts().timeGap,
                                        title: 'Burn',
                                        color: Color(0xffd75509),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ValueListenableBuilder<int>(
                                  valueListenable: controller.score,
                                  builder: (context, _score, __) {
                                    return Score(
                                      _score,
                                      widget.isMobile,
                                    );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SoundButton(
                  onTap: () async {
                    /*             if (musicPlayer == null) {
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
         */
                  },
                  isMuted: controller.isMuted,
                ),
              ),
            ),
            Visibility(
              visible: !widget.isMobile,
              child: Align(
                  alignment: Alignment.bottomRight, child: ChiefDecoration()),
            ),
          ],
        ),
      ),
    );
  }
}
