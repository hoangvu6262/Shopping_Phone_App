import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';

import '../home_page.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        showSearch(
            context: context, delegate: Search(productController.products));
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(color: bgColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        prefixIcon: SvgPicture.asset(
          'assets/icons/search.svg',
          fit: BoxFit.scaleDown,
          color: textColor,
        ),
        hintText: 'Enter keywords...',
      ),
    );
  }
}
