import 'package:flutter/material.dart';
import 'package:numbers/board/widgets/decoration.dart';
import 'package:numbers/shared/utils/media_query.dart';

class TutorialBody extends StatelessWidget {
  const TutorialBody({Key? key, required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF00d5f4),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/bg.jpg',
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  if (!MediaQueryUtils.isMobile(context)) RowDecoration(),
                  content,
                  if (!MediaQueryUtils.isMobile(context)) RowDecoration(),
                ],
              ),
            ],
          )),
    );
  }
}
