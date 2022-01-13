import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/board/board_consts.dart';
import 'package:numbers/board/widgets/decoration.dart';
import 'package:numbers/menu/menu_screen.dart';
import 'package:numbers/shared/utils/media_query.dart';
import 'package:numbers/tutorial/tutorial_consts.dart';

import 'back_symbol.dart';
import 'foward_symbol.dart';
import 'previous_button.dart';

class TutorialBody extends StatelessWidget {
  const TutorialBody({
    Key? key,
    required this.text,
    required this.board,
    required this.pos,
  }) : super(key: key);

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
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Flex(
                        direction: MediaQueryUtils.isMobile(context)
                            ? Axis.vertical
                            : Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () => Navigator.of(context)
                                  .pushAndRemoveUntil(
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const MenuScreen()),
                                      (route) => false),
                              child: PreviousButton(),
                            ),
                          ),
                          Flexible(
                            flex: MediaQueryUtils.isMobile(context) ? 11 : 4,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 444),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: EdgeInsets.all(
                                  (MediaQueryUtils.isMobile(context)
                                      ? BoardConsts.mobileGridPadding
                                      : BoardConsts.desktopGridPadding),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: board,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: MediaQueryUtils.isMobile(context) ? 7 : 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                text,
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Visibility(
                                      visible: pos > 0,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push<void>(
                                            MaterialPageRoute<void>(
                                                builder: (BuildContext
                                                        context) =>
                                                    TutorialConsts
                                                            .tutorialScreens[
                                                        pos - 1]),
                                          );
                                        },
                                        child: BackSymbol(),
                                      ),
                                    ),
                                    Visibility(
                                      visible: pos <
                                          TutorialConsts
                                                  .tutorialScreens.length -
                                              1,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute<void>(
                                                builder: (BuildContext
                                                        context) =>
                                                    TutorialConsts
                                                            .tutorialScreens[
                                                        pos + 1]),
                                          );
                                        },
                                        child: FowardSymbol(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Flexible(child: SizedBox.shrink())
                        ],
                      ),
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
