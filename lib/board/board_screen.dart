import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/board/widgets/sound_button.dart';
import 'package:numbers/game_over/game_over.dart';
import 'package:numbers/shared/templates/main_body.dart';

import '../main.dart';
import 'widgets/clock.dart';
import 'board_consts.dart';
import 'board_controller.dart';
import 'models/tile_model.dart';
import 'board_widget.dart';
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
  late Timer _refresh;
  late Timer _timer;

  late AudioCache audioCache;
  AudioPlayer? musicPlayer;

  bool _clockAlarm = false;

  @override
  void initState() {
    audioCache = AudioCache(prefix: "assets/audio/");

    controller = BoardController(
      widget.isMobile ? BoardConsts.mobileWidth : BoardConsts.desktopWidth,
      widget.isMobile ? BoardConsts.mobileHeight : BoardConsts.desktopHeight,
      audioCache: audioCache,
    );
    controller.tiles = List.generate(
      controller.width * controller.height,
      (index) => TileModel(
        key: GlobalKey(),
        number: Random().nextInt(5) + 1,
      ),
    );
    controller.setInitial();
    _refresh = Timer.periodic(Duration(milliseconds: 150), (t) {
      setState(() {
        controller.moveDown(t);
      });

      _clockAlarm = !_clockAlarm;
    });
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
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
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    _refresh.cancel();
    super.dispose();
  }

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
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: BoardWidget(controller: controller),
                        ),
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
                              ),
                              Clock(
                                counter: controller.burnTime,
                                amount: BoardConsts().timeGap,
                                title: 'Burn',
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
}
