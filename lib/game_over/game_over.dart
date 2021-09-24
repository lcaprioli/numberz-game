import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/board/board_screen.dart';
import 'package:numbers/board/widgets/decoration.dart';
import 'package:numbers/shared/templates/colors.dart';
import 'package:numbers/shared/templates/main_body.dart';
import 'package:numbers/shared/utils/media_query.dart';

class GameOver extends StatefulWidget {
  const GameOver({required this.score, required this.bestScore, Key? key})
      : super(key: key);
  final int score;
  final int bestScore;
  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      content: Expanded(
        child: Stack(
          children: [
            Flex(
              direction: MediaQueryUtils.isMobile(context)
                  ? Axis.vertical
                  : Axis.horizontal,
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
                          padding: EdgeInsets.all(30.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Game Over',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.gfsNeohellenic(
                                  textStyle: TextStyle(
                                    color: TemplateColors.colorDarkBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 48.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Score:',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.gfsNeohellenic(
                                      textStyle: TextStyle(
                                        color: TemplateColors.colorDarkBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '${widget.score}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.gfsNeohellenic(
                                      textStyle: TextStyle(
                                        color: TemplateColors.colorLightBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Best score:',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.gfsNeohellenic(
                                      textStyle: TextStyle(
                                        color: TemplateColors.colorDarkBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '${widget.bestScore}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.gfsNeohellenic(
                                      textStyle: TextStyle(
                                        color: TemplateColors.colorLightBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            BoardScreen(
                                          isMobile:
                                              MediaQueryUtils.isMobile(context),
                                          title: 'Game',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: TemplateColors.colorDarkBlue,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text(
                                        'Play again',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.gfsNeohellenic(
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: MediaQueryUtils.isMobile(context) ? 1 : 4,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [],
                  ),
                )
              ],
            ),
            Visibility(
              visible: !MediaQueryUtils.isMobile(context),
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Image.asset(
                      'assets/images/greek.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
