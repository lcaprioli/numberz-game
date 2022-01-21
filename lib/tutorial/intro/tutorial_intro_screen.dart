//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/templates/tutorial_text.dart';
import 'package:numbers/shared/utils/media_query.dart';

class TutorialIntroScreen extends StatefulWidget {
  const TutorialIntroScreen({
    Key? key,
  }) : super(key: key);

  @override
  _TutorialIntroScreenState createState() => _TutorialIntroScreenState();
}

class _TutorialIntroScreenState extends State<TutorialIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return TutorialBody(
      pos: 0,
      picture: Padding(
        padding: EdgeInsets.only(
          top: 100,
          left: MediaQueryUtils.isMobile(context) ? 15.0 : 40,
          right: MediaQueryUtils.isMobile(context) ? 15.0 : 40,
        ),
        child: SizedBox(
          width: MediaQueryUtils.isMobile(context)
              ? null
              : MediaQuery.of(context).size.height / 2,
          height: MediaQueryUtils.isMobile(context) ? 220 : null,
          child: Image.asset(
            'assets/images/greek.png',
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
      text: TutorialText(
        'Olá! eu sou o Yirgos e vou ensinar você a jogar LOUKOUMADES.',
      ),
    );
  }
}
