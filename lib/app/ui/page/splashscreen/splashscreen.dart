import 'package:flutter/material.dart';
import 'package:shopping_phone/app/ui/page/authentication/auth.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: new AuthenticationScreen(),
          title: new Text(
            'Welcome Back',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          image: new Image.asset('assets/images/logo.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: () => print("Flutter Egypt"),
          loaderColor: Colors.red),
    );
  }
}
