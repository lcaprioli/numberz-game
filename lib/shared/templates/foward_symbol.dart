import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/shared/utils/media_query.dart';

class FowardSymbol extends StatelessWidget {
  const FowardSymbol({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '>',
      style: GoogleFonts.gfsNeohellenic(
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          height: MediaQueryUtils.isMobile(context) ? .8 : 1,
          fontSize: MediaQueryUtils.isMobile(context) ? 27 : 32,
        ),
      ),
    );
  }
}
