import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/shared/utils/media_query.dart';

class TutorialText extends StatelessWidget {
  const TutorialText(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.gfsNeohellenic(
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          height: MediaQueryUtils.isMobile(context) ? .8 : 1,
          fontSize: MediaQueryUtils.isMobile(context) ? 24 : 32,
        ),
      ),
    );
  }
}
