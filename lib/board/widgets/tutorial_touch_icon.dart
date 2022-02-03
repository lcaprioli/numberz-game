import 'package:flutter/material.dart';
import 'package:numbers/shared/utils/media_query.dart';

class TutorialTouchIcon extends StatelessWidget {
  const TutorialTouchIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.touch_app,
      size: MediaQueryUtils.isMobile(context) ? 35 : 55,
      color: Colors.white,
    );
  }
}
