import 'package:flutter/material.dart';

class MediaQueryUtils {
  static isMobile(BuildContext context) => MediaQuery.of(context).size.width < 540;
}
