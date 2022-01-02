//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/board/board_consts.dart';
import 'package:numbers/board/models/tutorial_tile_model.dart';
import 'package:numbers/board/widgets/tutorial_tile.dart';
import 'package:numbers/menu/menu_screen.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/utils/media_query.dart';
import 'package:numbers/tutorial_1/tutorial_1_controller.dart';

class Tutorial2Screen extends StatefulWidget {
  Tutorial2Screen({
    Key? key,
    required this.title,
    required this.isMobile,
  }) : super(key: key);

  final String title;
  final bool isMobile;

  @override
  _Tutorial2ScreenState createState() => _Tutorial2ScreenState();
}

class _Tutorial2ScreenState extends State<Tutorial2Screen> {
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
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => MenuScreen()),
                              (Route<dynamic> route) => false);
                        },
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
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: widget.isMobile ? 10 : 40,
                      left: 40,
                      right: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sapien ante, dictum sit amet sagittis nec, sollicitudin eget nisi. Nunc euismod lectus nec aliquet scelerisque. Pellentesque blandit dapibus aliquam.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.gfsNeohellenic(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              height:
                                  MediaQueryUtils.isMobile(context) ? .8 : 1,
                              fontSize:
                                  MediaQueryUtils.isMobile(context) ? 27 : 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.chevron_left),
                          iconSize: 40,
                          color: Colors.white,
                          padding: EdgeInsets.zero,
                        ),
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
