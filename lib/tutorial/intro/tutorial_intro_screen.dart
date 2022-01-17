//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/board/widgets/tutorial_tile.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/templates/tutorial_text.dart';
import 'package:numbers/shared/utils/media_query.dart';
import 'package:numbers/tutorial/tutorial_1/tutorial_1_controller.dart';

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
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sapien ante, dictum sit amet sagittis nec, sollicitudin eget nisi. Nunc euismod lectus nec aliquet scelerisque. Pellentesque blandit dapibus aliquam.',
      ),
    );
  }
}
