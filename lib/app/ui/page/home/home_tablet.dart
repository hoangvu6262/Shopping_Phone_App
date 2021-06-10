import 'package:flutter/material.dart';

class HomeTablet extends StatelessWidget {
  const HomeTablet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.yellowAccent,
      child: Text("UI for Tablet"),
    );
  }
}
