import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/board/board_screen.dart';
import 'package:numbers/shared/templates/colors.dart';
import 'package:numbers/shared/templates/main_body.dart';
import 'package:numbers/shared/utils/media_query.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return MainBody(
      content: Expanded(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Text(
                              'LOUKUOMADES',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.gfsNeohellenic(
                                textStyle: TextStyle(
                                  color: TemplateColors.colorDarkBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 74.0,
                                ),
                              ),
                            ),
                            Text(
                              'Λουκουμάδες',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.gfsNeohellenic(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 68.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      color: TemplateColors.colorDarkBlue.withOpacity(.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: SizedBox(),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push<void>(
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => BoardScreen(
                                        title: 'Flutter Demo Home Page',
                                        isMobile: MediaQueryUtils.isMobile(context),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Start',
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: TemplateColors.colorDarkBlue.withOpacity(.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: SizedBox(),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Info',
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: !MediaQueryUtils.isMobile(context),
              child: Positioned.fill(
                left: 40,
                top: 40,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/greek.png',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
