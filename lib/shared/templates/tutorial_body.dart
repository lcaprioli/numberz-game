import 'package:flutter/material.dart';
import 'package:numbers/board/board_consts.dart';
import 'package:numbers/board/widgets/decoration.dart';
import 'package:numbers/menu/menu_screen.dart';
import 'package:numbers/shared/templates/colors.dart';
import 'package:numbers/shared/utils/media_query.dart';
import 'package:numbers/tutorial/tutorial_consts.dart';

import 'back_symbol.dart';
import 'foward_symbol.dart';
import 'previous_button.dart';

class TutorialBody extends StatelessWidget {
  const TutorialBody({
    Key? key,
    required this.text,
    required this.pos,
    this.board,
    this.picture,
  }) : super(key: key);

  final Widget text;
  final List<Widget>? board;
  final Widget? picture;
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
                                /*             padding: EdgeInsets.all(
                                  (MediaQueryUtils.isMobile(context)
                                      ? BoardConsts.mobileGridPadding
                                      : BoardConsts.desktopGridPadding),
                                ), */
                                child: board != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 25.0, top: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: board!,
                                        ),
                                      )
                                    : picture,
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
                                          print(pos);
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute<void>(
                                                builder: (BuildContext
                                                        context) =>
                                                    TutorialConsts
                                                            .tutorialScreens[
                                                        pos - 1]),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: BackSymbol(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: TutorialConsts
                                              .tutorialScreens.length *
                                          40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                          TutorialConsts.tutorialScreens.length,
                                          (index) => Container(
                                            decoration: BoxDecoration(
                                              color: pos == index
                                                  ? Colors.white
                                                  : TemplateColors
                                                      .colorDarkBlue,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            width: 10,
                                            height: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: pos <
                                          TutorialConsts
                                                  .tutorialScreens.length -
                                              1,
                                      child: InkWell(
                                        onTap: () {
                                          print(pos);
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute<void>(
                                                builder: (BuildContext
                                                        context) =>
                                                    TutorialConsts
                                                            .tutorialScreens[
                                                        pos + 1]),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FowardSymbol(),
                                        ),
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
