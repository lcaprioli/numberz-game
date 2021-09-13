import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/board/widgets/sound_button.dart';
import 'package:numbers/score/score_widget.dart';

import 'widgets/clock.dart';
import 'board_consts.dart';
import 'board_controller.dart';
import 'models/tile_model.dart';
import 'board_widget.dart';
import 'widgets/decoration.dart';

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
    });
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        controller.reduceTimer();
      });
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
    return Column(
      children: [
        RowDecoration(),
        Expanded(
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
                          BoardWidget(controller: controller),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: widget.isMobile ? 1 : 4,
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Clock(
                            counter: controller.seconds,
                          ),
                        ),
                        Score(
                          controller.score,
                          widget.isMobile,
                          controller.level,
                          controller.round,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Visibility(
                visible: !widget.isMobile,
                child: ChiefDecoration(),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Align(
                  alignment: Alignment.bottomRight,
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
        if (!widget.isMobile) RowDecoration(),
      ],
    );
  }
}
