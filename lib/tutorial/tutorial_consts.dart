import 'package:flutter/cupertino.dart';
import 'package:numbers/tutorial/intro/tutorial_intro_screen.dart';
import 'package:numbers/tutorial/tutorial_1/tutorial_1_screen.dart';
import 'package:numbers/tutorial/tutorial_2/tutorial_2_screen.dart';
import 'package:numbers/tutorial/tutorial_6/tutorial_6_screen.dart';

import 'tutorial_3/tutorial_3_screen.dart';
import 'tutorial_4/tutorial_4_screen.dart';
import 'tutorial_5/tutorial_5_screen.dart';

class TutorialConsts {
  static const List<StatefulWidget> tutorialScreens = [
    TutorialIntroScreen(),
    Tutorial1Screen(),
    Tutorial2Screen(),
    Tutorial3Screen(),
    Tutorial4Screen(),
    Tutorial5Screen(),
    Tutorial6Screen(),
  ];
}
