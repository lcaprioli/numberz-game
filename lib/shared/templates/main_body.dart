import 'package:flutter/material.dart';
import 'package:numbers/board/widgets/decoration.dart';
import 'package:numbers/shared/utils/media_query.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key, required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            RowDecoration(),
            content,
            if (!MediaQueryUtils.isMobile(context)) RowDecoration(),
          ],
        ),
      ],
    ));
  }
}
