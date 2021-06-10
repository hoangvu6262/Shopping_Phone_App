import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';

AppBar buildAppBar(BuildContext context,
    {String title, List<Widget> actions, Widget leading}) {
  return AppBar(
    backgroundColor: bgColor,
    brightness: Brightness.dark,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w300),
    ),
    centerTitle: true,
    leading: leading,
    actions: actions,
  );
}
