import 'package:flutter/material.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';

class DetailCategory extends StatelessWidget {
  const DetailCategory({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      padding: const EdgeInsets.all(10.0),
      margin: EdgeInsets.only(right: 20),
      child: Text(
        item.category,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
