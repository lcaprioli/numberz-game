import 'package:flutter/material.dart';
import 'package:numbers/shared/utils/media_query.dart';

class BackSymbol extends StatelessWidget {
  const BackSymbol({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '<',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        height: MediaQueryUtils.isMobile(context) ? .8 : 1,
        fontSize: MediaQueryUtils.isMobile(context) ? 27 : 32,
      ),
    );
  }
}
