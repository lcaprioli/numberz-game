//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/board/board_consts.dart';
import 'package:numbers/board/models/tutorial_tile_model.dart';
import 'package:numbers/board/widgets/tutorial_tile.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/templates/tutorial_text.dart';
import 'package:numbers/shared/utils/media_query.dart';
import 'package:numbers/tutorial_1/tutorial_1_controller.dart';
import 'package:numbers/tutorial_2/tutorial_2_screen.dart';

class Tutorial1Screen extends StatefulWidget {
  Tutorial1Screen({
    Key? key,
    required this.title,
    required this.isMobile,
  }) : super(key: key);

  final String title;
  final bool isMobile;

  @override
  _Tutorial1ScreenState createState() => _Tutorial1ScreenState();
}

class _Tutorial1ScreenState extends State<Tutorial1Screen> {
  late Tutorial1Controller controller;

  @override
  void initState() {
    controller = Tutorial1Controller(
      BoardConsts.width,
      BoardConsts.height,
      //     audioCache: audioCache,
    );
    controller.setInitial();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TutorialBody(
      content: Expanded(
        child: Stack(
          children: [
            Flex(
              direction: widget.isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.chevron_left),
                        iconSize: 40,
                        color: Colors.white,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 6,
                  fit: MediaQueryUtils.isMobile(context)
                      ? FlexFit.loose
                      : FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQueryUtils.isMobile(context) ? 20.0 : 30.0),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(controller.columns.length,
                                (columnIndex) {
                              return Container(
                                height: MediaQueryUtils.columnHeight(context),
                                width: MediaQueryUtils.columnWidth(context),
                                child: Stack(
                                  children: List.generate(
                                    controller
                                        .columns[columnIndex].value.length,
                                    (index) => ValueListenableBuilder<
                                            List<TutorialTileModel>>(
                                        valueListenable:
                                            controller.columns[columnIndex],
                                        builder: (_, list, __) {
                                          return TutorialTile(
                                            tile: list.reversed.toList()[index],
                                            index: index,
                                            isMobile: widget.isMobile,
                                          );
                                        }),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TutorialText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sapien ante, dictum sit amet sagittis nec, sollicitudin eget nisi. Nunc euismod lectus nec aliquet scelerisque. Pellentesque blandit dapibus aliquam.',
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    Tutorial2Screen(
                                  title: 'Flutter Demo Home Page',
                                  isMobile: MediaQueryUtils.isMobile(context),
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.chevron_right),
                          iconSize: 40,
                          color: Colors.white,
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
