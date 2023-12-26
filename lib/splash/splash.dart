import 'package:flutter/material.dart';
import 'package:numbers/menu/menu_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _opacity = 0.0;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _opacity = 1.0;
        });
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            _opacity = 0.0;
          });
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => MenuScreen(),
              ),
            );
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(
              milliseconds: 500,
            ),
            child: Image.asset(
              'assets/images/splash.png',
              width: 333,
            ),
          ),
          Visibility(
            visible: false,
            child: Text(
              ' ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
            ),
          ),
          Visibility(
            visible: false,
            child: Image.asset('assets/images/pattern.png'),
          ),
          Visibility(
            visible: false,
            child: Image.asset('assets/images/bg.png'),
          ),
        ],
      ),
    );
  }
}
