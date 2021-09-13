import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/score/score_widget.dart';

import 'board_clock.dart';
import 'board_consts.dart';
import 'board_controller.dart';
import 'board_tile_model.dart';
import 'board_widget.dart';

class BoardScreen extends StatefulWidget {
  BoardScreen({Key? key, required this.title, required this.isMobile}) : super(key: key);

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
/* 
  AudioPlayer? blopPlayer;

  AudioPlayer? fryPlayer; */

  @override
  void initState() {
    audioCache = AudioCache(prefix: "assets/audio/");

    controller = BoardController(
      widget.isMobile ? BoardConsts.mobileWidth : BoardConsts.desktopWidth,
      widget.isMobile ? BoardConsts.mobileHeight : BoardConsts.desktopHeight,
      /*     blopPlayer: blopPlayer,
      fryPlayer: fryPlayer, */
      audioCache: audioCache,
    );
    controller.tiles = List.generate(
      controller.width * controller.height,
      (index) => Tile(
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
        buildRowDecoration(),
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
                          //   BoardWidgetStack(controller: controller),
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
                child: Positioned(
                  right: 20,
                  bottom: 0,
                  width: 450,
                  child: Image.asset(
                    'assets/images/greek.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: _buildSoundButton(),
                ),
              )
            ],
          ),
        ),
        if (!widget.isMobile) buildRowDecoration(),
      ],
    );
  }

  MouseRegion _buildSoundButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
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
        child: ClipOval(
          child: Container(
            height: 60,
            width: 60,
            color: Colors.blue.shade800,
            child: Icon(
              controller.isMuted ? Icons.music_off : Icons.music_note,
              size: 33,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Row buildRowDecoration() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 65,
            child: Image.asset(
              'assets/images/pattern.png',
              repeat: ImageRepeat.repeatX,
              color: Color(0xFF0be1f7),
              colorBlendMode: BlendMode.multiply,
            ),
          ),
        )
      ],
    );
  }
}
