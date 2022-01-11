import 'package:flutter/material.dart';
import 'package:numbers/board/board_consts.dart';
import 'package:numbers/board/widgets/decoration.dart';
import 'package:numbers/menu/menu_screen.dart';
import 'package:numbers/shared/utils/media_query.dart';
import 'package:numbers/tutorial/tutorial_consts.dart';

class TutorialBody extends StatelessWidget {
  const TutorialBody(
      {Key? key, required this.text, required this.board, required this.pos})
      : super(key: key);

  final Widget text;
  final List<Widget> board;
  final int pos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF00d5f4),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/bg.jpg',
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  if (!MediaQueryUtils.isMobile(context)) RowDecoration(),
                  Expanded(
                    child: Stack(
                      children: [
                        Flex(
                          direction: MediaQueryUtils.isMobile(context)
                              ? Axis.vertical
                              : Axis.horizontal,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const MenuScreen()),
                                            (route) => false),
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
                                        MediaQueryUtils.isMobile(context)
                                            ? 20.0
                                            : 30.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: EdgeInsets.all(
                                          (MediaQueryUtils.isMobile(context)
                                                  ? BoardConsts
                                                      .mobileGridPadding
                                                  : BoardConsts
                                                      .desktopGridPadding) *
                                              2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: board,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            text,
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                      visible: pos > 0,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push<void>(
                                            MaterialPageRoute<void>(
                                                builder: (BuildContext
                                                        context) =>
                                                    TutorialConsts
                                                            .tutorialScreens[
                                                        pos - 1]),
                                          );
                                        },
                                        icon: Icon(Icons.chevron_left),
                                        iconSize: 40,
                                        color: Colors.white,
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                    Visibility(
                                      visible: pos <
                                          TutorialConsts
                                                  .tutorialScreens.length -
                                              1,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute<void>(
                                                builder: (BuildContext
                                                        context) =>
                                                    TutorialConsts
                                                            .tutorialScreens[
                                                        pos + 1]),
                                          );
                                        },
                                        icon: Icon(Icons.chevron_right),
                                        iconSize: 40,
                                        color: Colors.white,
                                        padding: EdgeInsets.zero,
                                      ),
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
                  if (!MediaQueryUtils.isMobile(context)) RowDecoration(),
                ],
              ),
            ],
          )),
    );
  }
}
