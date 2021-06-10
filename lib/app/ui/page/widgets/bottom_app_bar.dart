import 'package:shopping_phone/app/ui/page/home/home_page.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';

import '../more/more_page.dart';
import '../order/order_page.dart';
import '../category/category_page.dart';
import 'package:flutter/material.dart';
import 'package:shopping_phone/app/ui/shared/custom_bottomAppBar.dart';

import 'package:get/get.dart';

class SharedBottomAppBar extends StatefulWidget {
  @override
  _SharedBottomAppBarState createState() => _SharedBottomAppBarState();
}

class _SharedBottomAppBarState extends State<SharedBottomAppBar> {
  Widget _lastSelected = HomePage();

  List<Widget> pages = [
    MorePage(),
    OrderPage(),
    CategoryPage(),
    HomePage(),
  ];
  List<String> titles = ['more'.tr, 'my_orders'.tr, 'Categories'.tr, 'home'.tr];

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _lastSelected,
      bottomNavigationBar: Container(
        height: 60.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(25)),
        padding: EdgeInsets.symmetric(horizontal: 20 * 1.5),
        margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
        child: CustomBottomAppBar(
          color: Colors.white,
          backgroundColor: bgColor,
          selectedColor: textColor,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: _selectedTab,
          items: [
            BottomAppBarItem(iconData: Icons.person_rounded),
            BottomAppBarItem(iconData: Icons.payment_sharp),
            BottomAppBarItem(iconData: Icons.category_rounded),
            BottomAppBarItem(iconData: Icons.home),
          ],
        ),
      ),
    );
  }
}
