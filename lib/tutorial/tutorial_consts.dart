import 'package:flutter/cupertino.dart';
import 'package:numbers/tutorial/tutorial_1/tutorial_1_screen.dart';
import 'package:numbers/tutorial/tutorial_2/tutorial_2_screen.dart';

import 'tutorial_3/tutorial_3_screen.dart';
import 'tutorial_4/tutorial_4_screen.dart';

class TutorialConsts {
  static const List<StatefulWidget> tutorialScreens = [
    Tutorial1Screen(),
    Tutorial2Screen(),
    Tutorial3Screen(),
    Tutorial4Screen()
  ];
}
