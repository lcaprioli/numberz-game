import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numbers/shared/utils/media_query.dart';

import 'back_symbol.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction:
          MediaQueryUtils.isMobile(context) ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BackSymbol(),
        FittedBox(
          child: Text(
            ' VOLTAR',
            style: GoogleFonts.gfsNeohellenic(
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                height: MediaQueryUtils.isMobile(context) ? .8 : 1,
                fontSize: MediaQueryUtils.isMobile(context) ? 27 : 32,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
